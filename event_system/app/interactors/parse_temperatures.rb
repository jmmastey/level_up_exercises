require_relative 'data_repo'

class ParseTemperatures
  def self.call
    model_name = WeatherForecast
    method_name = :scrape_temperatures
    attributes_to_capture = (%w(high low))
    scraping = DataRepo.call(model_name, method_name, attributes_to_capture)
  end
end
