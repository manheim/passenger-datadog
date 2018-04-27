module Parsers
  class Base
    PREFIX = 'passenger'.freeze

    attr_reader :batch, :xml, :prefix, :tags

    def initialize(batch, xml, prefix: nil, tags: nil)
      @batch = batch
      @xml = xml
      @prefix = prefix
      @tags = tags
    end

    protected

    def gauge(xml_key, key)
      value = xml.xpath(xml_key).text
      return if value.empty?

      if tags
        batch.gauge(key_for(key), value, tags: tags)
      else
        batch.gauge(key_for(key), value)
      end
    end

    def key_for(key)
      [PREFIX, prefix, key].compact.join('.')
    end
  end
end
