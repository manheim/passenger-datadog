module Parsers
  class Root < Base
    STATS = {
      'process_count' => 'pool.used',
      'max' => 'pool.max',
      'get_wait_list_size' => 'request_queue'
    }.freeze

    def run
      STATS.each do |xml_key, key|
        gauge(xml_key, key)
      end
    end
  end
end
