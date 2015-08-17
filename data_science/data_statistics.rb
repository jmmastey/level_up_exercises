require 'abanalyzer'
require_relative "analyzer"
require_relative 'cohort_statistics'
require 'pp'

class DataStatistics
  attr_accessor :cohort_data, :values
  def initialize(filename)
    @cohort_data = Analyzer.new(filename).parse_data
    @values = nil
  end

  def convert_data_to_hash
    @cohort_data.each do |cohort, _|
      @values = CohortStatistics.new(cohort, @cohort_data).values
    end
  end

  def chi_square
    convert_data_to_hash
    tester = ABAnalyzer::ABTest.new @values
    pp tester.chisquare_p
  end
end
filename = 'test.json'
DataStatistics.new(filename).chi_square
