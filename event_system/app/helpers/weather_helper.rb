require 'nokogiri'
require 'open-uri'
module WeatherHelper
  BASE_URL = "http://forecast.weather.gov/MapClick.php?textField1=41.8500262820005&textField2=-87.65004892899964"
  def self.parse_temperatures
    if WeatherForecast.where("created_at::date = current_date").count <= 0
      document = fetch_document
      scraping =  WebScraper.scrape_temperatures document
      scraping.each do |key, hash_temp|
        wf = WeatherForecast.new
        wf.weather_day = key
        wf.high        = hash_temp["high"] if hash_temp["high"]
        wf.low         = hash_temp["low"]  if hash_temp["low"]
        wf.save!
      end
    else
      weather_forecast = WeatherForecast.select("weather_day,high,low").
                         where("created_at::date = current_date")
      scraping = {}
      weather_forecast.each do |rec|
        scraping[rec.weather_day] = {}
        scraping[rec.weather_day] = { "high" => rec.high, "low" => rec.low }
      end
    end
    scraping
  end

  def self.parse_details
    if WeatherForecastDetail.where("created_at::date = current_date").count <= 0
      document = fetch_document
      scraping =  WebScraper.detailed_scrape document
      scraping.each do |key, hash_temp|
        wfd = WeatherForecastDetail.new
        wfd.weather_day = key
        wfd.detail_afternoon = hash_temp["detail_afternoon"]  if hash_temp["detail_afternoon"]
        wfd.detail_night     = hash_temp["detail_night"] if hash_temp["detail_night"]
        wfd.save!
      end
    else
      weather_forecast = WeatherForecastDetail.select("weather_day,detail_night,detail_afternoon").
                         where("created_at::date = current_date")
      scraping = {}
      weather_forecast.each do |rec|
        scraping[rec.weather_day] = {}
        scraping[rec.weather_day] = { "detail_afternoon" => rec.detail_afternoon, "detail_night" => rec.detail_night }
      end
    end
    scraping.first(1)
  end

  def self.fetch_document
    # return Nokogiri::HTML(open(BASE_URL)) if !Rails.env.test?
    Nokogiri::HTML(File.open("temperatures.html", "r"))
  end
end

WeatherHelper.parse_details