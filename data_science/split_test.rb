require_relative 'split_test_data'
require 'json'
require 'abanalyzer'

COHORTS = 'A'..'Z'

class SplitTest
  attr_reader :data, :attempts, :successes

  def initialize(split_test_data)
    @data = split_test_data
    @attempts = data.attempts
    @successes = data.successes
  end

  def confidence(level_of_confidence = 0.95)
    confidence_intervals = Hash.new
    attempts.each do |cohort, _value|
      confidence_intervals[cohort] = ABAnalyzer.confidence_interval(successes[cohort], attempts[cohort], level_of_confidence)
    end
    confidence_intervals
  end

  def chi_square
    values = {}
    attempts.each do |cohort, _value|
      values[cohort] = 
      { 
        :converted => successes[cohort], 
        :unconverted => (attempts[cohort]-successes[cohort]) 
      }
    end
    tester = ABAnalyzer::ABTest.new values
    tester.chisquare_p
  end
end
