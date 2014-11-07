require 'rest-client'

class SummaryForecastWorker
  include Sidekiq::Worker
  include WorkerHelpers
  SUMMARY_URL = "http://www.weather.gov/forecasts/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php"
  SUMMARY_PARAMETERS = {"zipCodeList" => "60606", "format" => "12 hourly" }

  def perform
    data = RestClient.get(SUMMARY_URL, params: SUMMARY_PARAMETERS)
    unless data.include?("error")
      xml = Nokogiri::XML(data)
      save(xml)
    end
  end

  private

  def build_forecasts
    forecasts = Hash.new do |hash, key| 
      hash[key] = Forecast.find_or_create_by(date: DateTime.parse(key[:date_time]),
                                             zip_code: 60606)
      hash[key].date_description = key[:period]
      hash[key]
    end

    forecasts.tap do |fc|
      get_temps(fc)
      get_data(fc, 'probability-of-precipitation', :precipitation)
      get_attribute(fc, 'weather', :condition, 'weather-conditions', 'weather-summary')
      get_data(fc, 'conditions-icon', :icon_url, 'icon-link')
    end
  end

  def get_temps(forecasts)
    get_data(forecasts, 'temperature', :temperature) { |t| t['type'] == 'maximum' }
    get_data(forecasts, 'temperature', :temperature) { |t| t['type'] == 'minimum' }
  end
end
