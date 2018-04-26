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

    statsd.batch do |s|
      Parsers::Root.new(s, parsed.xpath('//info')).run

      parsed.xpath('//supergroups/supergroup').each do |supergroup|
        prefix = normalize_prefix(supergroup.xpath('name').text)
        Parsers::Group.new(s, supergroup.xpath('group'), prefix: prefix).run

        supergroup.xpath('group/processes/process').each_with_index do |process, index|
          Parsers::Process.new(s, process, prefix: prefix, tags: ["passenger-process:#{index}"]).run
        end
      end
    end
  end

  private

  def normalize_prefix(prefix)
    prefix.gsub(/(-|\s)/, "_").gsub(/(\W|\d)/i, "")
  end
end
