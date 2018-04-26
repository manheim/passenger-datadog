module Parsers
  class Group < Base
    STATS = %w[
      capacity_used
      get_wait_list_size
      disable_wait_list_size
      processes_being_spawned
      enabled_process_count
      disabling_process_count
      disabled_process_count
    ].freeze

    def run
      STATS.each do |key|
        gauge(key, key)
      end
    end
  end
end
