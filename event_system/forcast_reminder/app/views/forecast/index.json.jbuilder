json.current @conditions, :station_id, :location_name, :observation_time,
  :temperature, :condition, :wind, :pressure, :dew_point, :visibility,
  :humidity

json.hourly_forecast @hourly_forecast, :time, :temperature, :dew_point,
  :precipitation, :wind_speed, :wind_direction, :cloud_cover

json.extended_forecast @forecasts, :time, :temperature, :condition,
  :precipitation
