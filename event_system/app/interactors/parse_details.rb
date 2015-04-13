require_relative 'data_repo'

class ParseDetails

  def self.call
    model_name = WeatherForecastDetail
    method_name = :detailed_scrape
    attributes_to_capture = (%w(detail_afternoon detail_night))
    scraping = DataRepo.call(model_name, method_name, attributes_to_capture)
  end
end

