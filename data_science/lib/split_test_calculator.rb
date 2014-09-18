class SplitTestCalculator
  require 'abanalyzer'

  def initialize
  end

  def chi_square_test()
  end

  def conversion_percentage(conversions, total, confidence = 0.95)
    ABAnalyzer.confidence_interval(conversions,total, confidence)
  end
end
