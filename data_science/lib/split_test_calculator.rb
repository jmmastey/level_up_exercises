class SplitTestCalculator
  require 'abanalyzer'

  attr_reader :abtester

  def initialize
  end

  def chi_square_score
    @abtester.chisquare_score
  end

  def chi_square_pvalue
    @abtester.chisquare_p
  end

  def test_groups_are_different?
    @abtester.different?
  end

  def error_bars(conversions, total, confidence = 0.95)
    ABAnalyzer.confidence_interval(conversions,total, confidence)
  end

  def calculate(values)
    @abtester = ABAnalyzer::ABTest.new values
  end
end
