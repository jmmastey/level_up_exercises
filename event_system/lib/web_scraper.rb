require 'nokogiri'
require 'open-uri'

class WebScraper
  BASE_URL = "http://forecast.weather.gov/MapClick.php?textField1=41.8500262820005&textField2=-87.65004892899964"

  def self.scrape_temperatures(doc)
    document = doc

    low_high_temp = {}
    d1 = Date.today
    document.css("div.one-ninth-first").each do |para|
      if para.css("p.txt-ctr-caps").text[-5..-1].downcase == "night"
        low_high_temp[d1] ||= {}
        low_high_temp[d1]["low"] = para.css("p.point-forecast-icons-low").text
        .split(" ")[1]
        d1 += 1.day
      else
        low_high_temp[d1] ||= {}
        low_high_temp[d1]["high"] = para.css("p.point-forecast-icons-high").text
        .split(" ")[1]
      end
    end
    low_high_temp
  end

  def self.detailed_scrape(doc)
    document = doc
    temp_hash_description = {}
    top_level = document.search('div.point-forecast-7-day > ul > li')
    d1 = Date.today
    top_level.each do |li|
      temp_key = li.css("span.label").text
      li.css("span").remove
      if temp_key[-5..-1].downcase == "night"
        temp_hash_description[d1] ||= {}
        temp_hash_description[d1]["detail_night"] = li.text.strip
        d1 += 1.day
      else
        temp_hash_description[d1] ||= {}
        temp_hash_description[d1]["detail_afternoon"] = li.text.strip
      end
    end

    temp_hash_description
  end
end

