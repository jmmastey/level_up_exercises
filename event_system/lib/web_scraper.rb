require 'nokogiri'
require 'open-uri'

class WebScraper
  def self.scrape
    base_url = "http://forecast.weather.gov/MapClick.php?textField1=41.8500262820005&textField2=-87.65004892899964#.VCXEvOdNbH4"
    doc = Nokogiri::HTML(open(base_url))
    #prediction_date = ["Today", "Overnight", "Tonight", "This Afternoon"]

    forecast_hash = {}
    temp_hash = {}
    d1 = Date.today
    doc.css("div.one-ninth-first").map { |para|
      puts para.css("p.txt-ctr-caps").text
      if para.css("p.txt-ctr-caps").text[-5..-1].downcase == "night"
        temp_hash[d1] ||= {}
        temp_hash[d1]["low"] = para.css("p.point-forecast-icons-low").text.split(" ")[1]
        d1 = d1 + 1.day
      else
        temp_hash[d1] ||= {}
        temp_hash[d1]["high"] = para.css("p.point-forecast-icons-high").text.split(" ")[1]
      end
    }
    doc.css("ul.point-forecast-7-day li").map{ |li|
      forecast_hash << li.text
    }

    temp_hash
  end
end
