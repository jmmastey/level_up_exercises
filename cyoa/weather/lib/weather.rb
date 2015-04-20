require 'forecast_io'

module Weather

  def self.forecast
    ForecastIO.api_key = 'c5d11b292028d4dbfb798505da2a6dec'
    ForecastIO.forecast(41.8369, -87.6847)
  end
end
