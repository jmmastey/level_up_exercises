require "abtest/cohort"

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
      cohorts.each_with_object({}) do |cohort, conversions|
        conversions[cohort.name] = cohort.conversions
      end
    end

    def conversion_percentage_by_cohort
      cohorts.each_with_object({}) do |cohort, percentages|
        percentages[cohort.name] = cohort.conversion_percentage
      end
    end

    def standard_error_by_cohort
      cohorts.each_with_object({}) do |cohort, standard_errors|
        standard_errors[cohort.name] = cohort.standard_error
      end
    end

    def confidence_interval_by_cohort
      cohorts.each_with_object({}) do |cohort, confidence_intervals|
        confidence_intervals[cohort.name] = cohort.confidence_interval
      end
    end

    def chi_squared
      cohorts.inject(0) do |chi_squared, cohort|
        chi_squared + chi_squared_cohort(cohort)
      end.round(2)
    end

    def significant?
      chi_squared > CHI_SQUARED_THRESHOLD
    end

    private

    def samples_by_cohort
      @samples_by_cohort ||= @samples.group_by(&:cohort).values
    end

    def cohorts
      @cohorts ||= samples_by_cohort.map do |samples|
        Cohort.new(samples)
      end
    end

    def total_conversions
      cohorts.inject(0) { |total, cohort| total + cohort.conversions }
    end

    def average_conversions
      total_conversions.to_f / sample_size
    end

    def chi_squared_cohort(cohort)
      expected_conversions = average_conversions * cohort.sample_size
      expected_failures = (1 - average_conversions) * cohort.sample_size

      chi_squared_term(expected_conversions, cohort.conversions) +
        chi_squared_term(expected_failures, cohort.failures)
    end

    def chi_squared_term(expected, observed)
      (expected - observed)**2 / expected
    end
  end
end
