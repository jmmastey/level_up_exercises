require 'abanalyzer'
require_relative "analyzer"
require_relative 'cohort_statistics'
require 'pp'

class DataStatistics
	:cohort_data
  def initialize
    filename = 'test.json'
     @cohort_data = Analyzer.new(filename).parse_data
     @values = nil
  end
  
  def convert_data_to_hash
    @cohort_data.each {|cohort, value|
    	@values = CohortStatistics.new(cohort, @cohort_data).values
    }
  end

  def chi_square
    convert_data_to_hash
    tester = ABAnalyzer::ABTest.new @values
    pp tester.chisquare_p
  end
end

DataStatistics.new.chi_square