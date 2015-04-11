require_relative 'data_repo'

class ParseDetails

  def self.call
    if WeatherForecastDetail.today.empty?
      temp = DataRepo.parse_scraped_data(WeatherForecastDetail)
      scraping = temp.call("detailed_scrape")
    else
      weather_forecast_detail = WeatherForecastDetail.today.as_json
      details = DataRepo.structure_data(%w(detail_afternoon detail_night))
      scraping = details.call(weather_forecast_detail)
    end
    scraping
  end
end

