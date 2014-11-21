require 'abanalyzer'

class SplitTest

	def initialize(cohort_a, cohort_b)
		@cohort_a = cohort_a
		@cohort_b = cohort_b
	end

	def diff?
		values = {}
		values[:cohort_a] = { :sample_size => @cohort_a.sample_size, :success => @cohort_a.conversions }
		values[:cohort_b] = { :sample_size => @cohort_b.sample_size, :success => @cohort_b.conversions }

		tester = ABAnalyzer::ABTest.new(values)

		puts tester.chisquare_p
		# Are the two different?  Returns true or false (at 0.05 level of significance)
		tester.different?
	end
end