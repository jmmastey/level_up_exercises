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
    experiment.group_stats.each_with_object({}) do |(cohort, values), conversions|
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
    experiment.group_stats.each_with_object({}) do |(cohort, values), conversions|
      conversions[cohort] = values["expected_conversion_rate"]
    end
  end

  def average_conversions
    total_conversions.to_f / total_visits
  end

  def expected_conversions
    experiment.data.each_with_object({}) do |(cohort, values), expected_conversions|
      expected_conversions[cohort] = average_conversions * values["total_visits"]
    end
  end

  def expected_failures
    experiment.data.each_with_object({}) do |(cohort, values), expected_failures|
      expected_failures[cohort] = (1 - average_conversions) * values["total_visits"]
    end
  end

  def chi_squared_for_experiments
    experiment.data.each_with_object({}) do |(cohort, values), chi_squares|
      observed_conversion = values["conversions"]
      observed_failure    = ( values["total_visits"] - values["conversions"] )
      chi_squares[cohort] = (chi_squared_numerator(observed_conversion, expected_conversions[cohort]) +
        chi_squared_numerator(observed_failure, expected_failures[cohort])).round(2)
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
