require 'nokogiri'
require 'statsd'

class PassengerDatadog
  GROUP_STATS = %W(capacity_used processes_being_spawned enabled_process_count disabling_process_count disabled_process_count).freeze
  PROCESS_STATS = %w(processed sessions busyness concurrency cpu rss private_dirty pss swap real_memory vmsize uptime).freeze

  class << self
    def run
      @statsd = Statsd.new
      #status = `sudo passenger-status --show=xml`
      status = `passenger-status --show=xml`
      return if status.empty?

      # Good job Passenger 4.0.10. Return non xml in your xml output.
      status = status.split("\n")[3..-1].join("\n") unless status.start_with?('<?xml')
      parsed = Nokogiri::XML(status)

      pool_used = parsed.xpath('//process_count').text
      @statsd.gauge('passenger.pool.used', pool_used)

      pool_max = parsed.xpath('//max').text
      @statsd.gauge('passenger.pool.max', pool_max)

      request_queue = parsed.xpath('//supergroups/supergroup/group/get_wait_list_size').text
      @statsd.gauge('passenger.request_queue', request_queue)

      parsed.xpath('//supergroups/supergroup/group').each do |group|
        GROUP_STATS.each do |stat|
          @statsd.gauge("passenger.#{stat}", group.xpath(stat).text)
        end
      end

      parsed.xpath('//supergroups/supergroup/group/processes/process').each_with_index do |process, index|
        PROCESS_STATS.each do |stat|
          @statsd.gauge("passenger.#{stat}", process.xpath(stat).text, tags: ["passenger-process:#{index}"])
        end
      end
    end
  end
end
