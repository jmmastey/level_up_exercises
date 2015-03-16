require_relative 'file_parser'
require 'abanalyzer'

class Analyzer
  DECIMAL_PLACES = 2

  def initialize(filename)
    @parser = FileParser.new(filename)
    run
  end

  def print_stats
    print_cohorts
    print_confidence_level
  end

  def confidence_level
    ((1 - @tester.chisquare_p) * 100).round(DECIMAL_PLACES)
  end

  private

  def run
    create_cohorts
    ab_data = ab_analyzer_data
    @tester = ABAnalyzer::ABTest.new(ab_data)
  end

  def create_cohorts
    @cohort_a = Cohort.new(@parser.cohort_a)
    @cohort_b = Cohort.new(@parser.cohort_b)
  end

  def ab_analyzer_data
    values = {}
    values[:agroup] = @cohort_a.to_ab_hash
    values[:bgroup] = @cohort_b.to_ab_hash
    values
  end

  def print_cohorts
    puts "Cohort A:"
    puts @cohort_a
    puts "Cohort B:"
    puts @cohort_b
  end

  def print_confidence_level
    puts "Confidence level: #{confidence_level.round(2)}%"
  end
end

if __FILE__ == $PROGRAM_NAME
  # analyzer = Analyzer.new("data_export_2014_06_20_15_59_02.json")
  analyzer = Analyzer.new("data_simple_test.json")
  analyzer.print_stats
end
