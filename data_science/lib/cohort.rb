require_relative 'visit'
require 'abanalyzer'
require 'pry'

class Cohort
	attr_accessor :visits, :conversions

	def initialize(visits)
		validate_visits(visits)
		@visits = visits
		@conversions ||= conversions
	end

	def sample_size
		visits.length
	end

	def num_conversions
		conversions.length
	end

	def conversions
		converted = 1
		@conversions = visits.select{ |visit| visit.result == converted }
	end

	def conversion_rate(confidence = 0.95)
		ABAnalyzer.confidence_interval(num_conversions, sample_size, confidence)
	end

	def current_leader(cohort_to_compare)
		comparison = self.conversion_rate <=> cohort_to_compare.conversion_rate
		case
			when comparison > 0
				return self
			when comparison < 0
				return cohort_to_compare
			else
				"It's a tie!"
		end
	end

	private
	def validate_visits(visits)
		visit_cohort = visits.first.cohort
		if visits.find{ |visit| visit.cohort != visit_cohort}
			raise "All visits must be from the same cohort"
		end
	end
end