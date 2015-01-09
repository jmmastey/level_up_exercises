require 'abanalyzer'
require_relative 'cohort'

class ABCalculator
  def initialize(test_results)
    @a_cohort = Cohort.new("A", test_results.a_conv, test_results.a_nonconv)
    @b_cohort = Cohort.new("B", test_results.b_conv, test_results.b_nonconv)
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
