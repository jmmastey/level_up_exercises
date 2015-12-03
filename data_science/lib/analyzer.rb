require_relative '../lib/cohort'

class Analyzer
	def self.better_than_random_confidence(values)
		tester = ABAnalyzer::ABTest.new values
		tester.chisquare_score
	end
end