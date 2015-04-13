require 'nokogiri'
class WebScraper
  def self.scrape_temperatures(doc)
    document = doc
    low_high_temp = {}
    date = Date.today
    document.css("li.forecast-tombstone").each do |para|
      if para.css("p.txt-ctr-caps").text[-5..-1].downcase == "night"
        low_high_temp[date] ||= {}
        low_high_temp[date]["low"] = para.css("p.point-forecast-icons-low").text
        .split(" ")[1]
        date += 1.day
      else
        low_high_temp[date] ||= {}
        low_high_temp[date]["high"] = para.css("p.point-forecast-icons-high").text
        .split(" ")[1]
      end
    end
    low_high_temp
  end

  def self.detailed_scrape(doc)
    document = doc
    forecast_description = {}

    top_level = document.css('div#detailed-forecast-body')
    date = Date.today
    document.css('div.row-forecast').each do |para|
      temp_key = para.css('div.forecast-label').text
        if temp_key[-5..-1].downcase == "night"
          forecast_description[date] ||= {}
          forecast_description[date]["detail_night"] = para.css('div.forecast-text').text.strip
          date += 1.day
        else
          forecast_description[date] ||= {}
          forecast_description[date]["detail_afternoon"] = para.css('div.forecast-text').text.strip
        end
    end


    forecast_description
  end
end

