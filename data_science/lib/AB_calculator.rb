require 'abanalyzer'
require_relative 'cohort'
include Math

class ABCalculator
  def initialize(parsed_data)
    @a_cohort = Cohort.new("A", parsed_data[:a][:pass], parsed_data[:a][:fail])
    @b_cohort = Cohort.new("B", parsed_data[:b][:pass], parsed_data[:b][:fail])
    @a_b_tester = ABAnalyzer::ABTest.new(parsed_data)
  end

  def sample_size
    { a: @a_cohort.total_trials, b: @b_cohort.total_trials }
  end
  
  def no_of_conversions
    { a: @a_cohort.conversions, b: @b_cohort.conversions }
  end

  def conversion_rate
    { a: @a_cohort.conversion_rate, b: @b_cohort.conversion_rate }
  end

  def conversion_range
    { a: @a_cohort.conversion_range, b: @b_cohort.conversion_range }
  end

  def standard_error
    { a: @a_cohort.standard_error, b: @b_cohort.standard_error }
  end

  def confidence_level
    1 - @a_b_tester.chisquare_p
  end
end
