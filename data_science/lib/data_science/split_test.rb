require 'abanalyzer'

class DataScience::SplitTest
  def initialize(cohort_a, cohort_b)
    @cohort_a = cohort_a
    @cohort_b = cohort_b
    @test     = ABAnalyzer::ABTest.new(values)
  end

  def chisquare_p_value
    @test.chisquare_p.round(3)
  end

  def different?
    @test.different?
  end

  private

  def values
    {
      cohort_a: {
        sample_size: @cohort_a.trials,
        success: @cohort_a.conversions,
      },
      cohort_b: {
        sample_size: @cohort_b.trials,
        success: @cohort_b.conversions,
      },
    }
  end
end
