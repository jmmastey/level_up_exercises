require 'nokogiri'
require 'open-uri'

class WebScraper
  BASE_URL = "http://forecast.weather.gov/MapClick.php?textField1=41.8500262820005&textField2=-87.65004892899964#.VCXEvOdNbH4"


  def self.scrape_temperatures
    doc = Nokogiri::HTML(open(BASE_URL))

    temp_hash = {}
    d1 = Date.today
    doc.css("div.one-ninth-first").map do |para|
      if para.css("p.txt-ctr-caps").text[-5..-1].downcase == "night"
        temp_hash[d1] ||= {}
        temp_hash[d1]["low"] = para.css("p.point-forecast-icons-low").text
                               .split(" ")[1]
        d1 += 1.day
      else
        temp_hash[d1] ||= {}
        temp_hash[d1]["high"] = para.css("p.point-forecast-icons-high").text
                                .split(" ")[1]
      end
    end
    temp_hash
  end

  def self.detailed_scrape
    doc = Nokogiri::HTML(open(BASE_URL))
    temp_hash_description = {}
    top_level = doc.search('div.point-forecast-7-day > ul > li')
    top_level.each do |li|
      temp_key = li.css("span.label").text
      li.css("span").remove
      temp_hash_description[temp_key] = li.text
    end
    Rails.logger.info "DETAILED SCRAPE #{temp_hash_description}"

    temp_hash_description
  end
end
