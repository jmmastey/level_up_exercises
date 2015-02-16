module NWS
  class Forecast
    attr_reader :zip_code, :periods

    def initialize(zip_code, periods)
      @zip_code = zip_code
      @periods = periods
    end

    def ==(other)
      zip_code == other.zip_code && periods == other.periods
    end
  end
end
