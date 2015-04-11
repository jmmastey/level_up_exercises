require 'nokogiri'
class WebScraper
  def self.scrape_temperatures(doc)
    document = doc
    low_high_temp = {}
    d1 = Date.today
    document.css("li.forecast-tombstone").each do |para|
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

    top_level = document.css('div#detailed-forecast-body')
    d1 = Date.today
    document.css('div.row-forecast').each do |para|
      temp_key = para.css('div.forecast-label').text
        if temp_key[-5..-1].downcase == "night"
          temp_hash_description[d1] ||= {}
          temp_hash_description[d1]["detail_night"] = para.css('div.forecast-text').text.strip
          d1 += 1.day
        else
          temp_hash_description[d1] ||= {}
          temp_hash_description[d1]["detail_afternoon"] = para.css('div.forecast-text').text.strip
        end
    end


    temp_hash_description
  end
end

