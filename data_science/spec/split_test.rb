require 'abanalyzer'

class SplitTest

	def initialize(cohort_a, cohort_b)
		@cohort_a = cohort_a
		@cohort_b = cohort_b
	end

	# at 0.05 level of significance
	def different? 
		# tester.chisquare_p
		tester.different?
	end

	private 
	
	def tester
		ABAnalyzer::ABTest.new(values)
	end

	def values
		{
			cohort_a: { 
			  	:sample_size => @cohort_a.sample_size, 
	  			:success => @cohort_a.conversions 
			},
			cohort_b: { 
				:sample_size => @cohort_b.sample_size, 
				:success => @cohort_b.conversions 
			}
		}
	end

end