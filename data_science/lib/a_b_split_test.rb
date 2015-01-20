require 'abanalyzer'

class ABSplitTest
  attr_reader :a_cohort, :b_cohort
  def initialize(a_b_tally)
    @a_cohort = Cohort.new(a_b_tally.a_conv, a_b_tally.a_nonconv)
    @b_cohort = Cohort.new(a_b_tally.b_conv, a_b_tally.b_nonconv)
    @a_b_test = ABAnalyzer::ABTest.new(a_b_tally.to_h)
  end

  def confidence_level
    (1 - @a_b_test.chisquare_p).round(6)
  end

  def test_winner
    if different?
      @a_cohort.conversion_rate > @b_cohort.conversion_rate ? "A" : "B"
    else
      "No winner at 0.05 significance"
    end
  end

  def to_s
    "A cohort data:\n#{@a_cohort}\nB cohort data:\n#{@b_cohort}"
  end

  private

  def different?
    @a_b_test.different?
  end
end
