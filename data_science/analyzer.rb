require 'abanalyzer'

class Analyzer
  attr_accessor :cohorts, :abanalyzer, :p_value

  def initialize(cohorts, p_value = 0.05)
    @cohorts = cohorts
    @p_value = p_value
    initialize_abanalyzer
  end

  def initialize_abanalyzer
    values = {}
    @cohorts.each { |k, v| values[k] = v.conversion_stats }
    @abanalyzer = ABAnalyzer::ABTest.new(values)
  end

  def better_than_random?
    @abanalyzer.chisquare_p < @p_value
  end

  def print_results
    @cohorts.values.each(&:print_info)
    puts "Test Results:"
    puts 'Better than random? ' + better_than_random?.to_s
  end
end
