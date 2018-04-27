# frozen_string_literal: true

require 'nokogiri'
require 'datadog/statsd'

require 'parsers/base'
require 'parsers/root'
require 'parsers/group'
require 'parsers/process'

class PassengerDatadog
  def run
    status = `passenger-status --show=xml`
    return if status.empty?

    # Good job Passenger 4.0.10. Return non xml in your xml output.
    status = status.split("\n")[3..-1].join("\n") unless status.start_with?('<?xml')

    statsd = Datadog::Statsd.new
    parsed = Nokogiri::XML(status)

    statsd.batch do |batch|
      run_in_batch(batch, parsed)
    end
  end

  private

  def run_in_batch(batch, parsed)
    Parsers::Root.new(batch, parsed.xpath('//info')).run

    multiple_supergroups = parsed.xpath('//supergroups/supergroup').count > 1
    parsed.xpath('//supergroups/supergroup').each do |supergroup|
      prefix = multiple_supergroups ? normalize_prefix(supergroup.xpath('name').text) : nil
      Parsers::Group.new(batch, supergroup.xpath('group'), prefix: prefix).run

      supergroup.xpath('group/processes/process').each_with_index do |process, index|
        Parsers::Process.new(batch, process, prefix: prefix, tags: ["passenger-process:#{index}"]).run
      end
    end
  end

  def normalize_prefix(prefix)
    prefix.gsub(/(-|\s)/, '_').gsub(/(\W|\d)/i, '')
  end
end
