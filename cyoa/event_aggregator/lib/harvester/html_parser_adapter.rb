require "nokogiri"

module Harvester
  class HtmlScraper
    class HtmlParserAdapter < Nokogiri::XML::SAX::Document
      def initialize(parent_html_scraper)
        @scraper = parent_html_scraper
      end

      def start_element(name, attrs = [])
        @scraper.start_element(name, attrs)
      end

      def end_element(name)
        @scraper.end_element(name)
      end
    end
  end
end

