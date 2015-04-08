require_relative 'split_test_data'
require 'json'
require 'abanalyzer'

COHORTS = 'A'..'Z'

class SplitTest
  attr_reader :data

  def initialize(split_test_data)
    @test_data = split_test_data
  end

  def confidence(successes, attempts, level_of_confidence = 0.95)
    ABAnalyzer.confidence_interval(successes, attempts, level_of_confidence)
  end

  def sample_size(baseline, base_plus_lift, significance, power)
    ABAnalyzer.calculate_size(baseline, base_plus_lift, significance, power)
  end
end