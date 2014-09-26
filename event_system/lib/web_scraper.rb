require 'nokogiri'
require 'open-uri'

class WebScraper
  def self.scrape
    base_url = "http://forecast.weather.gov/MapClick.php?textField1=41.8500262820005&textField2=-87.65004892899964#.VCXEvOdNbH4"
    doc = Nokogiri::HTML(open(base_url))

    forecast_hash = []
    doc.css("ul.point-forecast-7-day li").map{ |li|
      forecast_hash << li.text
    }

    forecast_hash
  end
end
