require_relative 'data_repo'

class ParseTemperatures

  def self.call
    if WeatherForecast.today.empty?
      temp  = DataRepo.parse_scraped_data(WeatherForecast)
      scraping = temp.call("scrape_temperatures")
    else
      weather_forecast = WeatherForecast.today.as_json
      temperatures = DataRepo.structure_data(%w(high low))
      scraping = temperatures.call(weather_forecast)
    end
    scraping
  end

end