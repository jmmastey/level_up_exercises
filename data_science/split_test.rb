require 'json'
require 'abanalyzer'
require_relative 'cohort'

class SplitTest
  attr_reader :cohorts

  def initialize(cohorts)
    @cohorts = cohorts
  end

  def conversion_rates
    @cohorts.each_with_object([]) { |cohort, rates| rates << cohort.conversion_rate }
  end

  def confidence(level_of_confidence = 0.95)
    @cohorts.each_with_object([]) do |cohort, levels|
      levels << ABAnalyzer.confidence_interval(cohort.successes, cohort.attempts, level_of_confidence)
    end
  end

  def chi_square
    values = {}
    @cohorts.each do |cohort|
      values[cohort.name] = 
      { 
        :converted => cohort.successes, 
        :unconverted => cohort.failures
      }
    end
    tester = ABAnalyzer::ABTest.new values
    tester.chisquare_p
  end
end
