class SummaryForecastWorker < BaseForecastWorker
  private

  def request_url
    "http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php"
  end

  def base_request_parameters
    { "format" => "12 hourly" }
  end

  def build_forecasts(options = {})
    forecasts = Hash.new do |hash, key| 
      hash[key] = Forecast.find_or_create_by(date: key[:date_time],
                                             zip_code: options[:zip_code])
      hash[key].date_description = key[:period]
      hash[key]
    end

    forecasts.tap do |fc|
      get_data(fc, 'temperature', :temperature) { |t| t['type'] == 'maximum' }
      get_data(fc, 'temperature', :temperature) { |t| t['type'] == 'minimum' }
      get_data(fc, 'probability-of-precipitation', :precipitation)
      get_attribute(fc, 'weather', :condition, 'weather-conditions', 'weather-summary')
      get_data(fc, 'conditions-icon', :icon_url, 'icon-link')
    end
  end
end
