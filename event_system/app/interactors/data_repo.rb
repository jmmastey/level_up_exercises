require 'nokogiri'
require 'open-uri'

class DataRepo

  BASE_URL = "http://forecast.weather.gov/MapClick.php?textField1=41.8500262820005&textField2=-87.65004892899964"
  def self.document
    if Rails.env.test?
      @document ||= Nokogiri::HTML(File.open("temperatures.html", "r"))
    else
      @document ||= Nokogiri::HTML(open(BASE_URL))
    end
  end

  def self.parse_scraped_data(model_name)
    return Proc.new  do |method|
      scraping = WebScraper.send method, document
      scraping.each do |day, hash_temp|
        save_scraped_data(day, hash_temp, model_name.new)
      end
    end
  end

  def self.structure_data(params)
    return Proc.new do |model|
      model.each_with_object({}) do |hash, return_hash|
        return_hash[hash["weather_day"]] = { params[0] => hash[params[0]], params[1] => hash[params[1]] }
      end
    end
  end

  def self.save_scraped_data(day, scraped_data, wf)
    wf[:weather_day] = day
    wf.attributes.each do |attr, value|
      next unless scraped_data[attr]
      wf[attr.to_sym] = scraped_data[attr]
    end
    wf.save!
  end
end