require "abanalyzer"

require_relative "data_loader"

class DataAnalyzer
  attr_reader :groups

  SIGNIFICANCE_THRESHOLD = 0.05

  def initialize(loader)
    @loader = loader
  end

  def load(args)
    @groups = {}
    args.each do |group, criteria|
      groups[group] = @loader.fetch(criteria)
    end
  end

  def sample_size(group = nil)
    return groups[group].size if group
    groups.values.flatten.size
  end

  def conversion_count(group)
    groups[group].count { |i| i[:result] != 0 }
  end

  def conversion_rate(group)
    conversion_count(group).to_f / sample_size(group)
  end

  def confidence_interval(group, confidence)
    success = conversion_count(group)
    total = sample_size(group)
    low, high = ABAnalyzer.confidence_interval(success, total, confidence)

    { low: low, high: high }
  end

  def p_value
    tester = ABAnalyzer::ABTest.new(compose_values)
    tester.chisquare_p
  end

  def significant?
    p_value < SIGNIFICANCE_THRESHOLD
  end

  def compose_values
    values = {}
    groups.keys.each do |group|
      successes = conversion_count(group)
      failures = sample_size(group) - successes
      values[group] = { successes: successes, failures: failures }
    end
    values
  end
end
