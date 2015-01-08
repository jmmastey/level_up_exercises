require_relative 'experiment'

class Calculator

  def initialize(file_name = "source_data.json")
    @file = file_name
  end

  def conversion_rate_for_experiments
    experiment.data.each_with_object({}) do |(cohort, values), conversions|
        conversions[cohort] = experiment.observed_conversion_rate(cohort)
    end
  end

  def standard_error_for_experiments
     experiment.data.each_with_object({}) do |(cohort, values), error|
        error[cohort] = experiment.standard_error(cohort)
    end
  end

  def visits_for_experiment
    experiment.data.each_with_object({}) do |(cohort, values), conversions|
      conversions[cohort] = experiment.data[cohort]["total_visits"]
    end
  end

  def conversions_for_experiment
    experiment.data.each_with_object({}) do |(cohort, values), conversions|
      conversions[cohort] = experiment.data[cohort]["conversions"]
    end
  end

  def total_visits
    visits_for_experiment.inject(0) do |sum,(k,v)|
      sum += v
    end
  end

  def total_conversions
    conversions_for_experiment.inject(0) do |sum,(k,v)|
      sum += v
    end
  end

  def expected_conversion_rate_for_experiments
    experiment.data.each_with_object({}) do |(cohort, values), conversions|
        conversions[cohort] = experiment.expected_conversion_rate(cohort)
    end
  end

  def average_conversions
    total_conversions.to_f / total_visits
  end

  def expected_conversions
    experiment.data.each_with_object({}) do |(cohort, values), expected_conversions|
      expected_conversions[cohort] = average_conversions * visits_for_experiment[cohort]
    end
  end

   def expected_failures
    experiment.data.each_with_object({}) do |(cohort, values), expected_failures|
      expected_failures[cohort] = (1 - average_conversions) * visits_for_experiment[cohort]
    end
  end

  def chi_squared_for_experiments
    experiment.data.each_with_object({}) do |(cohort, values), chi_squares|
      chi_squares[cohort] = (chi_squared_numerator(conversions_for_experiment[cohort], expected_conversions[cohort]) +
        chi_squared_numerator((visits_for_experiment[cohort] - conversions_for_experiment[cohort]),
                                expected_failures[cohort])).round(2)
    end
  end

  def chi_squared_numerator(observed, expected)
    (observed - expected)**2 / expected
  end

  def chi_square
    puts chi_squared_for_experiments.inspect
    chi_squared_for_experiments.inject(0) do |sum,(k,v)|
      sum += v
    end
  end

  def experiment
    @experiment ||= Experiment.new(@file)
  end
end
