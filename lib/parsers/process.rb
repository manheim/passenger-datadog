module Parsers
  class Process < Base
    STATS = %w[
      processed
      sessions
      busyness
      concurrency
      cpu
      rss
      private_dirty
      pss
      swap
      real_memory
      vmsize
    ].freeze

    def run
      STATS.each do |key|
        gauge(key, key)
      end
    end
  end
end
