require_relative 'view_helpers'

module DataScience
  class Cohort
    include ViewHelpers

    attr_accessor :conversions, :non_conversions

    CONVERSION_RATE_MULTIPLIER_95_CONFIDENCE = 1.96

    def initialize
      @conversions = 0
      @non_conversions = 0
    end

    def <<(data)
      @conversions +=  data.count { |visit| visit["result"] == 1 }
      @non_conversions +=  data.count { |visit| visit["result"] == 0 }
    end

    def size
      conversions + non_conversions
    end

    def conversion_rate
      1.0 * conversions / size
    end

    def standard_error
      error_factor = (1 - conversion_rate) / size
      Math.sqrt(conversion_rate * error_factor)
    end

    def error_bars
      standard_error * CONVERSION_RATE_MULTIPLIER_95_CONFIDENCE * 100
    end
  end
end
