# frozen_string_literal: true
require 'nokogiri'
require 'statsd'

class PassengerDatadog
  GROUP_STATS = %w(capacity_used processes_being_spawned enabled_process_count
                   disabling_process_count disabled_process_count).freeze
  PROCESS_STATS = %w(processed sessions busyness concurrency cpu rss
                     private_dirty pss swap real_memory vmsize).freeze

  class << self
    def run
      app_base = "/srv/healthcare/"
      apps = Dir["#{app_base}*"]
      passenger_instances = {}

      # Cycle through all WEB passenger instances
      apps.each do |app|
        instance = %x{
          grep -Po '(?<=\"name\" : \")[a-zA-Z0-9]*' \
          $(dirname \
            $(grep -l \
              $(cat #{app}/current/tmp/pids/passenger.pid) \
              $(find /tmp/passenger.*/web_server* -name "*control_process.pid") \
            ) | cut -d'/' -f-3 \
          )/properties.json
        }

        if instance != ""
          passenger_instances[app] ||= {}
          passenger_instances[app][:web] = instance.strip
        end
      end

      # Cycle through all API passenger instances
      apps.each do |app|
        instance = %x{
          grep -Po '(?<=\"name\" : \")[a-zA-Z0-9]*' \
          $(dirname \
            $(grep -l \
              $(cat #{app}/current/tmp/pids/api-passenger.pid) \
              $(find /tmp/passenger.*/web_server* -name "*control_process.pid") \
            ) | cut -d'/' -f-3 \
          )/properties.json
        }

        if instance != ""
          passenger_instances[app] ||= {}
          passenger_instances[app][:api] = instance.strip
        end
      end

      passenger_instances.each do |app, hash|
        hash.each do |target, instance|
          status = `passenger-status #{instance} --show=xml`
          return if status.empty?

          environment = case app[-1]
            when "s"
              "staging"
            when "p"
              "production"
            when "d"
              "development"
          end

          clean_app = app.gsub(app_base,"")

          statsd = Statsd.new('localhost', 8125, :tags => ["application:#{clean_app}", "environment:#{environment}", "target:#{target}"])

          statsd.batch do |s|
            # Good job Passenger 4.0.10. Return non xml in your xml output.
            status = status.split("\n")[3..-1].join("\n") unless status.start_with?('<?xml')
            parsed = Nokogiri::XML(status)

            resisting_deployment_error = parsed.xpath('//supergroups/supergroup/group').children.map(&:name).include?("resisting_deployment_error")

            if resisting_deployment_error
              s.gauge('passenger.resisting_deployment_error', 1)
            else
              s.gauge('passenger.resisting_deployment_error', 0)
            end

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
                s.gauge("passenger.#{stat}", value, :tags => ["passenger-process:#{index}"])
              end
            end
          end
        end
      end
    end
  end
end
