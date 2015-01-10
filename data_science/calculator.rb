require_relative 'experiment'

class Calculator
  def initialize(file_name = "source_data.json")
    @file = file_name
    build_experiments
  end

  def build_experiments
    experiment.data.each_key do |cohort|
      experiment.observed_conversion_rate(cohort)
      experiment.standard_error(cohort)
      experiment.expected_conversion_rate(cohort)
    end
  end

  def conversion_rate_for_experiments
    experiment.group_stats
      .each_with_object({}) do |(cohort, values), conversions|
      conversions[cohort] = values["conversion_rate"]
    end
  end

  def standard_error_for_experiments
    experiment.group_stats.each_with_object({}) do |(cohort, values), error|
      error[cohort] = values["standard_error"]
    end
  end

  def visits_for_experiment
    experiment.data.each_with_object({}) do |(cohort, values), conversions|
      conversions[cohort] = values["total_visits"]
    end
  end

  def conversions_for_experiment
    experiment.data.each_with_object({}) do |(cohort, values), conversions|
      conversions[cohort] = values["conversions"]
    end
  end

  def total_visits
    visits_for_experiment.inject(0) do |sum, (_k, v)|
      sum + v
    end
  end

  def total_conversions
    conversions_for_experiment.inject(0) do |sum, (_k, v)|
      sum + v
    end
  end

  def expected_conversion_rate_for_experiments
    experiment.group_stats
      .each_with_object({}) do |(cohort, values), conversions|
      conversions[cohort] = values["expected_conversion_rate"]
    end
  end

  def average_conversions
    total_conversions.to_f / total_visits
  end

  def expected_conversions
    experiment.data
      .each_with_object({}) do |(cohort, values), expected_conversions|
      expected_conversions[cohort] = average_conversions *
        values["total_visits"]
    end
  end

  def expected_failures
    experiment.data
      .each_with_object({}) do |(cohort, values), expected_failures|
      expected_failures[cohort] = (1 - average_conversions) *
        values["total_visits"]
    end
  end

  def chi_squared_for_experiments
    experiment.data.each_with_object({}) do |(cohort, values), chi_squares|
      observed_conversions = values["conversions"]
      observed_failures    = (values["total_visits"] - values["conversions"])
      e_conv               = expected_conversions[cohort]
      e_failed             = expected_failures[cohort]
      conversions_squared  = chi_squared_numerator(observed_conversions, e_conv)
      failures_squared     = chi_squared_numerator(observed_failures, e_failed)
      chi_squares[cohort]  = (conversions_squared + failures_squared).round(2)
    end
  end

  def chi_squared_numerator(observed, expected)
    (observed - expected)**2 / expected
  end

  def chi_square
    chi_squared_for_experiments.inject(0) do |sum, (_k, v)|
      sum + v
    end
  end

  def experiment
    @experiment ||= Experiment.new(@file)
  end
end
