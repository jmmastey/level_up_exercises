require "uri"

module Harvester
  module ChicagoTheater
    class MainPageScraper
      include Harvester::HtmlScraper::HtmlScraperStrategy

      # Links to event pages are found as href in:
      # <a href="..." class="detailhead">...</a>
      def run
        event_links.each { |link| collect_event_information(link) }
      end

      private

      def event_links
        document.css('a.detailhead').map { |link| URI.join(uri, link['href']) }
      end

      def collect_event_information(event_uri)
        detail_harvester(event_uri).run(html_scraper.event_producer)
      end

      def detail_harvester(event_uri)
        detail_scraper = DetailPageScraper.new
        Harvester::HtmlScraper.new(event_uri, detail_scraper)
      end
    end
  end
end
