module ABTest
  class Analyzer
    CHI_SQUARED_THRESHOLD = 3.841

    def initialize(samples)
      @samples = samples
    end

    def sample_size
      @samples.size
    end

    def conversions_by_cohort
      cohorts.each_with_object({}) do |(cohort, samples), conversions|
        conversions[cohort] = samples.count { |sample| sample.result == 1 }
      end
    end

    def conversion_percentage_by_cohort
      cohorts.each_with_object({}) do |(cohort, samples), percentages|
        conversions = samples.count { |sample| sample.result == 1 }
        percentages[cohort] = (conversions.to_f / samples.size) * 100
      end
    end

    def standard_error_by_cohort
      cohorts.each_with_object({}) do |(cohort, samples), standard_errors|
        conversions = samples.count { |sample| sample.result == 1 }
        conversion_rate = conversions.to_f / samples.size
        standard_error = standard_error(conversion_rate, samples.size)
        standard_errors[cohort] = standard_error.round(5)
      end
    end

    def confidence_interval_by_cohort
      standard_error_by_cohort.each_with_object({}) do |(cohort, standard_error), confidence_intervals|
        standard_error *= 100
        conversion_percentage = conversion_percentage_by_cohort[cohort]
        lower = conversion_percentage - (1.96 * standard_error)
        upper = conversion_percentage + (1.96 * standard_error)
        confidence_intervals[cohort] = [lower.round(2), upper.round(2)]
      end
    end

    def total_conversions
      @samples.count { |sample| sample.result == 1 }
    end

    def chi_squared
      cohorts.inject(0) do |chi_squared, (_, samples)|
        chi_squared + chi_squared_cohort(samples)
      end.round(2)
    end

    def significant?
      chi_squared > CHI_SQUARED_THRESHOLD
    end

    private

    def cohorts
      @cohorts ||= @samples.group_by(&:cohort)
    end

    def standard_error(conversion_rate, sample_size)
      Math.sqrt(conversion_rate * (1 - conversion_rate) / sample_size)
    end

    def average_conversions
      total_conversions.to_f / sample_size
    end

    def chi_squared_cohort(samples)
      chi_squared_term(average_conversions * samples.size,
        conversions_cohort(samples)) +
        chi_squared_term((1 - average_conversions) * samples.size,
          failures_cohort(samples))
    end

    def failures_cohort(samples)
      samples.size - conversions_cohort(samples)
    end

    def conversions_cohort(samples)
      samples.count { |sample| sample.result == 1 }
    end

    def chi_squared_term(expected, observed)
      (expected - observed)**2 / expected
    end
  end
end
