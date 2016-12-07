require_relative 'page_parser'
require 'open-uri'

module TheatreInChicago
  module Scraper
    END_POINT = "http://www.theatreinchicago.com/"
    QUERY = "searchresults.php?"
    MISC_OPTIONS = "&txtTitle=&txtGenre=&txtArea=&txtDateF=null&txtDateT=null&QFdate=1"

    def self.add_events(time)
      uri = construct_uri(time)
      node = Nokogiri::HTML(open(uri))
      TheatreInChicago::PageParser.new(node).events.each do |event|
        ShowingsHelper.add_theatre_in_chicago(event)
      end
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
