require "nokogiri"
require "open-uri"

require "harvester/html_scraper_strategy"

module Harvester
  class HtmlScraper
    EVENT_SOURCE_TYPE = "HTML"

    attr_reader :collection_strategy, :event_producer, :uri, :document
    attr_accessor :current_state, :set_event_source, :event_source_name

    def initialize(uri, collection_strategy, opts = {})
      @uri = uri
      @event_producer = nil
      @collection_strategy = collection_strategy
      @set_event_source = opts.fetch(:set_event_source, false)
    end

    def run(event_producer)
      @event_producer = event_producer
      setup_processing_context
      collection_strategy.run
    end

    def event_source_name
      return @event_source_name if @event_source_name
      title_node = document.css('title').first
      @event_source_name = title_node ? title_node.text.strip : uri.to_s
    end

    private

    def setup_processing_context
      @document = Nokogiri::HTML(open(uri), uri.to_s)
      setup_event_source if set_event_source
      collection_strategy.initialize_collection(self)
    end

    def setup_event_source
      event_producer.setup_event_source(name: event_source_name,
                                        source_type: EVENT_SOURCE_TYPE,
                                        uri: uri.to_s)
    end
  end
end


