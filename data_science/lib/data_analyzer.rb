require '../lib/cohort.rb'
require '../lib/data_parser.rb'
require 'abanalyzer'
class DataAnalyzer
  DECIMAL_PLACES = 2
  attr_accessor :data_parser
  def initialize(file)
    @data_parser = DataParser.new(file)
    create_cohorts
  end

  def create_cohorts
    @cohort_a = Cohort.new(@data_parser.cohort_a)
    @cohort_b = Cohort.new(@data_parser.cohort_b)
  end

  def build_ab_analyzer_data
    data = {}
    data[:acohort] = { :success => @cohort_a.conversions, :fails => @cohort_a.non_conversions }
    data[:bcohort] = { :success => @cohort_b.conversions, :fails => @cohort_b.non_conversions }
    data
  end

  def calculate_confidence_level
    ab_tester = ABAnalyzer::ABTest.new(build_ab_analyzer_data)
    (1 - ab_tester.chisquare_p).round(DECIMAL_PLACES)
  end

  def display_data
    puts "Cohort A"
    puts @cohort_a
    puts "Cohort B"
    puts @cohort_b
    puts "Confidence Level: #{calculate_confidence_level * 100}%"
  end

end

#analyzer = DataAnalyzer.new('../data_export_2014_06_20_15_59_02.json')
#analyzer.display_data
