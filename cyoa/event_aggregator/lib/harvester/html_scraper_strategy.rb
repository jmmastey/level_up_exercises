module Harvester
  class HtmlScraper
    module HtmlScraperStrategy
      attr_accessor :html_scraper

      def initialize_collection(html_scraper)
        @html_scraper = html_scraper
      end

      def document
        html_scraper.document
      end

      def uri
        html_scraper.uri
      end

      def event_producer
        html_scraper.event_producer
      end

      def event_data_context
        event_producer.event_data_context
      end

      def new_event_attributes
        event_producer.event_data_context[:event_attributes]
      end

      def run
        raise NotImplementedError
      end
    end
  end
end
