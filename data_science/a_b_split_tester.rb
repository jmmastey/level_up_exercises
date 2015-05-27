require 'abanalyzer'
require_relative './data_loader.rb'

class ABSplitTester
  def initialize(data)
    @cohorts = []
    @visitors = {}
    @conversions = {}

    process(data)
  end

  def cohorts_count
    @cohorts.size
  end

  def conversion_count(cohort)
    raise "Invalid Cohort" unless @cohorts.include? cohort
    @conversions[cohort]
  end

  def conversion_rate(cohort)
    raise "Invalid Cohort" unless @cohorts.include? cohort

    ABAnalyzer.confidence_interval(@conversions[cohort],
      @visitors[cohort], 0.95)
  end

  def confidence_score
    tester = ABAnalyzer::ABTest.new ab_value_map

    1 - tester.chisquare_p
  end

  private

  def process(data)
    data.each do |row|
      @cohorts << row["cohort"] unless @cohorts.include? row["cohort"]
      @conversions[row["cohort"]] ||= 0
      @visitors[row["cohort"]] ||= 0
      @conversions[row["cohort"]] += row["result"]
      @visitors[row["cohort"]] += 1
    end
  end

  def ab_value_map
    values = {}
    @conversions.each do |cohort, value|
      values[cohort] = {
        converted: value, not_converted: (@visitors[cohort] - value)
      }
    end
    values
  end
end
