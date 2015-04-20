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

  def self.call(model_name, method_name, attributes)
    if model_name.today.empty?
      forecast = parse_scraped_data(model_name)
      scraping = forecast.call(method_name)
    else
      forecast = model_name.today.as_json
      details = structure_data(attributes)
      scraping = details.call(forecast)
    end
    scraping
  end

  def self.parse_scraped_data(model_name)
    return Proc.new  do |method|
      scraping = WebScraper.send method, document
      scraping.each do |day, scraped_data|
        save_scraped_data(day, scraped_data, model_name.new)
      end
    end
  end

  def self.structure_data(key_params)
    return Proc.new do |model|
      model.each_with_object({}) do |hash, return_hash|
        return_hash[hash["weather_day"]] = { key_params[0] => hash[key_params[0]],
                                             key_params[1] => hash[key_params[1]] }
      end
    end
  end

  def self.save_scraped_data(day, scraped_data, forecast_model)
    forecast_model[:weather_day] = day
    forecast_model.attributes.each do |attr, value|
      next unless scraped_data[attr]
      forecast_model[attr.to_sym] = scraped_data[attr]
    end
    forecast_model.save!
  end
end
