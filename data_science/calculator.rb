require_relative 'experiment'

class Calculator

  P_VALUE_TABLE = { 25 =>    [1.32, 2.77, 4.11, 5.39, 6.63, 7.84, 9.04,
                              10.22, 11.39, 12.55],
                    20 =>    [1.64, 3.22, 4.64, 5.59, 7.29, 8.56, 5.8,
                              11.03, 12.24, 13.44],
                    15 =>    [2.07, 3.79, 5.32, 6.74, 8.12, 9.45,
                              10.75, 12.03, 13.29, 14.53],
                    10 =>    [2.71, 4.61, 6.25, 7.78, 9.24, 10.64,
                              12.02, 13.36, 14.68, 15.99],
                    5  =>    [3.84, 5.99, 7.81, 9.49, 11.07, 12.53,
                              14.07,15.51, 16.92, 18.31],
                    2.5 =>   [5.02, 7.38, 9.35, 11.14, 12.83, 14.45, 16.01,
                              17.53,19.02, 20.48],
                    2 =>     [5.41, 7.82, 9.84, 11.67, 13.33, 15.03,
                              16.62,18.17, 19.63, 21.16],
                    1 =>     [6.63, 9.21, 11.34, 13.24, 15.09, 16.81,
                              18.48, 20.09, 21.67, 23.21],
                    0.05 =>  [7.88, 10.6, 12.84, 14.86, 16.75, 13.55,
                              20.28, 21.95, 23.59, 25.19],
                    0.025 => [9.14, 11.98, 14.32, 16.42, 18.39, 20.25,
                              22.04, 23.77, 25.46, 27.11],
                    0.01 =>  [10.83, 13.82, 16.27, 18.47, 20.51,
                              22.46, 24.32, 26.12, 27.83, 29.59],
                    0.005 => [12.12, 15.2, 17.73, 20, 22.11, 24.1,
                              26.02, 27.87, 29.67, 31.42] }

  SIGNIFICANT_PERCENTAGE = 5

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

  def degrees_of_freedom
    experiment.cohorts.count - 1
  end

  def p_value_index
    P_VALUE_TABLE.select do |_percent, dof|
      p_value_matched?(dof)
    end.keys.first
  end

  def p_value
    [p_value_index, next_higher_value]
  end

  def winner
    conversions = {}
    experiment.cohorts.each do |cohort|
      conversions[cohort.name] = cohort.conversion_rate
    end
    conversions.select { |_cohort, conv| conv == conversions.values.max }.keys.first
  end

  def significant?
    p_value.max >= SIGNIFICANT_PERCENTAGE
  end

private

  def percentages
    P_VALUE_TABLE.keys
  end

  def previous_percentages_index
    return 0 if  percentages.index(p_value_index)
    percentages.index(p_value_index)-1
  end

  def next_higher_value
    percentages[previous_percentages_index]
  end

  def p_value_matched?(dof)
    index = degrees_of_freedom - 1
    dof[index] >= chi_square
  end
end
