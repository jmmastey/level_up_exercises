require_relative 'page_parser'
require 'open-uri'

module TheatreInChicago
  module Scraper
    END_POINT = "http://www.theatreinchicago.com/"
    QUERY = "searchresults.php?"
    MISC_OPTIONS = "&txtTitle=&txtGenre=&txtArea=&txtDateF=null&txtDateT=null&QFdate=1"

    def self.get_events(time)
      uri = construct_uri(time)
      node = Nokogiri::HTML(open(uri))
      parser = TheatreInChicago::PageParser.new(node)
      parser.events.map { |chicago_event| chicago_event.to_event_model }
    end

    private

    def self.construct_uri(time)
      [END_POINT,
       QUERY,
       sprintf("txtDate=%04d-%02d-%02d", time.year, time.month, time.day),
       MISC_OPTIONS].join('')
    end
  end
end
