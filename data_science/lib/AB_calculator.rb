require 'abanalyzer'
require_relative 'cohort'

class ABCalculator
  def initialize(test_data)
    raise "Invalid input" unless test_data.is_a?(ABDataSummary)
    @a_cohort = Cohort.new("A", test_data.a_conv, test_data.a_nonconv)
    @b_cohort = Cohort.new("B", test_data.b_conv, test_data.b_nonconv)
    @a_b_test = ABAnalyzer::ABTest.new(a: @a_cohort.to_h, b: @b_cohort.to_h)
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
    (1 - @a_b_test.chisquare_p).round(6)
  end
end
