require 'abanalyzer'
require_relative 'a_b_cohort'

class ABCalculator
  def initialize(data_summary)
    # raise "Invalid input" unless data_summary.is_a?(ABDataSummary)
    @a_cohort = ABCohort.new("A", data_summary.a_conv, data_summary.a_nonconv)
    @b_cohort = ABCohort.new("B", data_summary.b_conv, data_summary.b_nonconv)
    @a_b_test = ABAnalyzer::ABTest.new(a: @a_cohort.to_h, b: @b_cohort.to_h)
  end

  def confidence_level
    (1 - @a_b_test.chisquare_p).round(6)
  end
end
