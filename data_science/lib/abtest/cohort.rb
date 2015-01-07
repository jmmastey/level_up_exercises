module ABTest
  class Cohort
    CONFIDENCE_95 = 1.96

    def initialize(samples)
      @samples = samples
    end

    def name
      @samples[0].cohort
    end

    def conversions
      @conversions ||= @samples.count { |sample| sample.result == 1 }
    end

    def conversion_rate
      conversions.to_f / sample_size
    end

    def sample_size
      @samples.size
    end

    def conversion_percentage
      conversion_rate * 100
    end

    def standard_error
      Math.sqrt(conversion_rate * (1 - conversion_rate) / sample_size).round(5)
    end

    def confidence_interval
      difference = standard_error * CONFIDENCE_95 * 100
      lower = conversion_percentage - difference
      upper = conversion_percentage + difference
      [lower.round(2), upper.round(2)]
    end

    def failures
      sample_size - conversions
    end
  end
end
