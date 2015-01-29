require 'savon'
require 'nws_request'

class WeatherRequest < NWSRequest
  # Ref: graphical.weather.gov/xml/
  # "glance" returns all data between the start and end times
  # for the parameters maxt, mint, sky, wx, and icons
  DEFAULT_PRODUCT = "glance"

  # "e" is English, "m" is Metric
  DEFAULT_UNIT = "e"

  operations :NDFDgen_lat_lon_list

  def self.NDFDgen_lat_lon_list(inputs = {})
    super(message: { list_lat_lon:       inputs.fetch(:list_lat_lon, null),
                     product:            inputs.fetch(:product, DEFAULT_PRODUCT),
                     start_time:         inputs.fetch(DateTime.iso8601(start_time), null),
                     end_time:           inputs.fetch(DateTime.iso8601(end_time), null),
                     unit:               inputs.fetch(:unit, DEFAULT_UNIT),
                     weather_parameters: inputs.fetch(:weather_parameters, null) })
  end
end
