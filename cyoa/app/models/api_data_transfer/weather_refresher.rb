require './app/models/point'
require './app/models/forecast_type'
require './app/models/api_data_transfer/weather_loader'

module WeatherRefresher
  DEFAULT_ZIP = "60606"

  def self.refresh_if_needed
    if ForecastType.needs_refresh?
      WeatherLoader.load(WeatherClient, list_lat_lon: self.class.default_lat_lon)
    end
  end

  def self.default_lat_lon
    point = Point.where(zip: DEFAULT_ZIP).first
    "#{point.lat.to_s}#{WeatherClient::LAT_LON_DELIMITER}#{point.lon.to_s}"
  end
end
