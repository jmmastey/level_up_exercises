class HourlyForecastWorker < BaseForecastWorker
  private

  def request_url
    "http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdXMLclient.php"
  end

  def base_request_parameters
    {"product" => "time-series", "temp" => "temp", "dew" => "dew",
     "qpf" => "qpf", "sky" => "sky", "wspd" => "wspd", "wdir" => "wdir",
     'icons' => 'icons'}
  end

  def build_forecasts(parameters = {})
    forecasts = Hash.new do |hash, key| 
      hash[key] = HourlyForecast.find_or_create_by(time: key[:date_time],
                                                   zip_code: parameters[:zip_code])
    end

    request_time = head.at_xpath('product/creation-date').text
    request_time = DateTime.parse(request_time).beginning_of_hour
    @time_limit = request_time + 1.day

    forecasts.tap do |fc|
      get_data(fc, 'temperature', :temperature) { |t| t['type'] == 'hourly' }
      get_data(fc, 'temperature', :dew_point) { |t| t['type'] == 'dew point' }
      get_data(fc, 'precipitation', :precipitation) { |t| t['type'] == 'liquid' }
      get_data(fc, 'wind-speed', :wind_speed) { |t| t['type'] == 'sustained' }
      get_data(fc, 'direction', :wind_direction) { |t| t['type'] == 'wind' }
      get_data(fc, 'cloud-amount', :cloud_cover) { |t| t['type'] == 'total' }
      get_data(fc, 'conditions-icon', :icon_url, 'icon-link') { |t| t['type'] == 'forecast-NWS' }
    end
  end
end
