require_relative 'theatre_in_chicago_page_parser'
require 'open-uri'

class TheatreInChicagoScraper
  END_POINT = "http://www.theatreinchicago.com/opening/"
  QUERY = "CalendarMonthlyResponse.php?"

  def self.get_events(year, month)
    uri = construct_uri(year, month)
    body = get_page_content(uri)
    parser = TheatreInChicagoPageParser.new(body)
    parser.events
  end

  private

  def self.get_page_content(uri)
    file = open(uri)
    file.read
  end

  def self.construct_uri(year, month)
    END_POINT + QUERY + arguments(year, month)
  end

  def self.arguments(year, month)
    "ran=#{random_number}&month=#{month}&year=#{year}"
  end

  def self.random_number
    Random.new.rand(9998) + 1
  end
end
