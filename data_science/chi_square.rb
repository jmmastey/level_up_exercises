require 'abanalyzer'
require_relative "analyzer"
require_relative 'cohort_statistics'

class ChiSquare
	def initialize
		filename = 'test.json'
    @cohort_data = Analyzer.new(filename).parse_data
	end

	#values[:agroup] = { :opened => 100, :unopened => 300 }
	#values[:bgroup] = { :opened => 50, :unopened => 350 }
	def convert_data_to_hash
		@cohort_data.each {|cohort, value|
			pp CohortStatistics.new(cohort, @cohort_data).values
		}
	end
end

ChiSquare.new.convert_data_to_hash