require 'rest-client'

class HourlyForecastWorker
  include Sidekiq::Worker
  include WorkerHelpers
  URL = "http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdXMLclient.php"
  PARAMETERS = {"zipCodeList" => "60606", "product" => "time-series" }

  def perform
    data = RestClient.get(URL, params: PARAMETERS)
    unless data.include?("error")
      xml = Nokogiri::XML(data)
      save(xml)
    end
  end

  def build_forecasts
    forecasts = Hash.new do |hash, key| 
      hash[key] = HourlyForecast.find_or_create_by(time: DateTime.parse(key[:date_time]),
                                                   zip_code: 60606)
    end

    forecasts.tap do |fc|
      get_data(fc, 'temperature', :temperature, 'value', 24) { |t| t['type'] == 'hourly' }
    end
  end
end
