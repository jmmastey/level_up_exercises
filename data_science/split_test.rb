require 'json'
require 'abanalyzer'
require_relative 'cohort'

class SplitTest
  attr_reader :cohorts

  def initialize(cohorts)
    @cohorts = cohorts
  end

  def conversion_rates
    @cohorts.map(&:conversion_rate)
  end

  def confidence(level_of_confidence = 0.95)
    @cohorts.map { |cohort| ABAnalyzer.confidence_interval(cohort.successes, cohort.attempts, level_of_confidence) }
  end

  def chi_square
    values = {}
    @cohorts.each do |cohort|
      values[cohort.name] =
      {
        converted: cohort.successes,
        unconverted: cohort.failures
      }
    end
    tester = ABAnalyzer::ABTest.new values
    tester.chisquare_p
  end
end
