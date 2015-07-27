require_relative 'json_reader'
require_relative 'cohort'
require 'abanalyzer'

class DataAnalyzer
  NINETY_FIVE_PERCENT = 0.95

  def initialize(file_path)
    @data = JSONReader.read_file(file_path)
    @cohort_a = Cohort.new("A", @data)
    @cohort_b = Cohort.new("B", @data)
  end

  def confident?
    tester = ABAnalyzer::ABTest.new(values_to_hash)
    tester.chisquare_score.round(3) < (1 - NINETY_FIVE_PERCENT)
  end

  def values_to_hash
    {
      a: {conversion: @cohort_a.conversions, fails: @cohort_a.fails},
      b: {conversion: @cohort_b.conversions, fails: @cohort_b.fails}
    }
  end
end
