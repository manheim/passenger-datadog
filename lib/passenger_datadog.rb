# frozen_string_literal: true

require 'nokogiri'
require 'datadog/statsd'

class PassengerDatadog
  GROUP_STATS = %w[capacity_used processes_being_spawned enabled_process_count
                   disabling_process_count disabled_process_count].freeze
  PROCESS_STATS = %w[processed sessions busyness concurrency cpu rss
                     private_dirty pss swap real_memory vmsize].freeze

  class << self
    def run
      status = `passenger-status --show=xml`
      return if status.empty?

      statsd = Datadog::Statsd.new

      statsd.batch do |s|
        # Good job Passenger 4.0.10. Return non xml in your xml output.
        status = status.split("\n")[3..-1].join("\n") unless status.start_with?('<?xml')
        parsed = Nokogiri::XML(status)

        pool_used = parsed.xpath('//process_count').text
        s.gauge('passenger.pool.used', pool_used)

        pool_max = parsed.xpath('//max').text
        s.gauge('passenger.pool.max', pool_max)

        request_queue = parsed.xpath('//supergroups/supergroup/group/get_wait_list_size').text
        s.gauge('passenger.request_queue', request_queue)

        parsed.xpath('//supergroups/supergroup/group').each do |group|
          GROUP_STATS.each do |stat|
            value = group.xpath(stat).text
            next if value.empty?
            s.gauge("passenger.#{stat}", value)
          end
        end

        parsed.xpath('//supergroups/supergroup/group/processes/process').each_with_index do |process, index|
          PROCESS_STATS.each do |stat|
            value = process.xpath(stat).text
            next if value.empty?
            s.gauge("passenger.#{stat}", value, tags: ["passenger-process:#{index}"])
          end
        end
      end
    end
  end
end
