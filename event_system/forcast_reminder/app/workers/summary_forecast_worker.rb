class SummaryForecastWorker < BaseForecastWorker
  private

  def find_or_create_model(time, values, zip_code, _dwml)
    unless values[:temperature].blank?
      Forecast.find_or_create_by(time: time[:date_time], zip_code: zip_code)
        .tap { |forecast| forecast.date_description = time[:period] }
    end
  end

  def request_url
    "http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php"
  end

  def request_parameters(zip_code)
    {
      format: "12 hourly",
      begin: Time.zone.now.iso8601,
      zipCodeList: zip_code,
    }
  end

  def data_fields
    [
      { attribute: 'temperature', map_name: :temperature, data_path: 'value', type: 'maximum' },
      { attribute: 'temperature', map_name: :temperature, data_path: 'value', type: 'minimum' },
      { attribute: 'probability-of-precipitation', map_name: :precipitation, data_path: 'value' },
      { attribute: 'conditions-icon', map_name: :icon_url, data_path: 'icon-link' },
      { attribute: 'weather', map_name: :condition, data_path: 'weather-conditions/@weather-summary' },
    ]
  end
end
