
class WeatherController < ApplicationController
  def index
    if params.has_key? "region"
      Rails.logger.info " PARAMS #{params["region"]["name"].inspect}"
      if WeatherForecast.where("created_at::date = current_date").count <= 0
        @scraping =  WebScraper.scrape

        @scraping.each do |key,hash_temp|
          wf = WeatherForecast.new
          wf.weather_day = key
          wf.high        = hash_temp["high"] if hash_temp.has_key? "high"
          wf.low         = hash_temp["low"]  if hash_temp.has_key? "low"
          wf.save!
        end
      else
        weather_forecast = WeatherForecast.select("weather_day,high,low").where("created_at::date = current_date")
        @scraping = {}
        weather_forecast.each do |rec|
          puts rec
          @scraping[rec.weather_day] = {}
          @scraping[rec.weather_day] = {"high" => rec.high, "low" => rec.low}
        end
      end
    end
  end

  def show

  end
end
