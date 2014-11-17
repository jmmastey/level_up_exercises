class HourlyForecastWorker < BaseForecastWorker
  private

  def find_or_create_model(time, values, zip_code, dwml)
    if !values[:temperature].blank? &&
        time[:date_time] < (dwml.request_time + max_time)
      HourlyForecast.find_or_create_by(time: time[:date_time], zip_code: zip_code)
    end
  end

  def request_url
    "http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdXMLclient.php"
  end

  def request_parameters(zip_code)
    {
      product: 'time-series',
      temp: 'temp',
      dew: 'dew',
      qpf: 'qpf',
      sky: 'sky',
      wspd: 'wspd',
      wdir: 'wdir',
      icons: 'icons',
      begin: Time.zone.now.iso8601,
      zipCodeList: zip_code,
    }
  end

  def data_fields
    [
      { attribute: 'temperature', map_name: :temperature, data_path: 'value', type: 'hourly' },
      { attribute: 'temperature', map_name: :dew_point, data_path: 'value', type: 'dew point' },
      { attribute: 'precipitation', map_name: :precipitation, data_path: 'value' },
      { attribute: 'wind-speed', map_name: :wind_speed, data_path: 'value', type: 'sustained' },
      { attribute: 'direction', map_name: :wind_direction, data_path: 'value', type: 'wind' },
      { attribute: 'cloud-amount', map_name: :cloud_cover, data_path: 'value', type: 'total' },
      { attribute: 'conditions-icon', map_name: :icon_url, data_path: 'icon-link', type: 'forecast-NWS' },
    ]
  end

  def max_time
    1.day
  end
end
