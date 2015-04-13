require 'forecast_io'

module Weather

  def forecast
    ForecastIO.api_key = 'cd420e15df0312aaf354aac347b7a6b8'
    ForecastIO.forecast(41.8369, -87.6847)
  end
end
