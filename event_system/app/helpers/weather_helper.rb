module WeatherHelper

  BASE_URL = "http://forecast.weather.gov/MapClick.php?textField1=41.8500262820005&textField2=-87.65004892899964"

  def self.parse_temperatures
    if WeatherForecast.where("created_at::date = current_date").count <= 0
      document = fetch_document
      @scraping =  WebScraper.scrape_temperatures document
      @scraping.each do |key, hash_temp|
        wf = WeatherForecast.new
        wf.weather_day = key
        wf.high        = hash_temp["high"] if hash_temp["high"]
        wf.low         = hash_temp["low"]  if hash_temp["low"]
        wf.save!
      end
    else
      weather_forecast = WeatherForecast.select("weather_day,high,low").
                         where("created_at::date = current_date")
      @scraping = {}
      weather_forecast.each do |rec|
        @scraping[rec.weather_day] = {}
        @scraping[rec.weather_day] = { "high" => rec.high, "low" => rec.low }
      end
    end
    @scraping
  end

  def self.fetch_document
    # return Nokogiri::HTML(open(BASE_URL)) if !Rails.env.test?
    Nokogiri::HTML(File.open("temperatures.html", "r"))
  end
end
