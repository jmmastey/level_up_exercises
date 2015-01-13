require_relative 'experiment'

class Calculator
  def initialize(file_name = "source_data.json")
    @file = file_name
  end

  def experiment
    @experiment ||= Experiment.new(@file)
  end

  def expected_conversions(cohort_name)
    experiment.expected_conversions[cohort_name]
  end

  def expected_failures(cohort_name)
    experiment.expected_failures[cohort_name]
  end

  def chi_squared_for_experiments
    experiment.cohorts.each_with_object({}) do |cohort, chi_squares|
      e_conv               = expected_conversions(cohort.name)
      e_failed             = expected_failures(cohort.name)
      conversions_squared  = chi_squared_numerator(cohort.conversions, e_conv)
      failures_squared     = chi_squared_numerator(cohort.failures, e_failed)
      chi_squares[cohort.name]  = (conversions_squared + failures_squared).round(2)
    end
  end

  def chi_squared_numerator(observed, expected)
    (observed - expected)**2 / expected
  end

  def chi_square
    chi_squared_for_experiments.values.inject(:+)
  end
end
