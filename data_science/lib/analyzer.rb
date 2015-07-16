require 'abanalyzer'

class Analyzer
  attr_accessor :analyzer

  def initialize(groups)
    @analyzer = ABAnalyzer::ABTest.new(groups)
  end

  def winner?
    analyzer.different?
  end
end
