require 'abanalyzer'

class Cohort
	CONFIDENCE_LEVEL = 0.95
	attr_reader :visitors

	def initialize(*visitors)
		@visitors = visitors
	end

	def sample_size
		@visitors.length
	end

	def add(visitor)
		@visitors << visitor
		self
	end

	def conversions
		@visitors.select {|member| member.result == 1}.length
	end

	def conversion_percentage
		return 0 unless sample_size > 0
		conversions.to_f/sample_size.to_f
	end

	def confidence_interval
		ABAnalyzer.confidence_interval(conversions, sample_size, CONFIDENCE_LEVEL)
	end
end