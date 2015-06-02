require 'abanalyzer'
require_relative './data_loader.rb'

class ABSplitTester
  def initialize(data)
    @cohorts = []
    @visits = {}
    @conversions = {}
    @confidence_interval = 0.95
    process(data)
  end

  def cohorts_count
    @cohorts.size
  end

  def conversion_count(cohort)
    raise "Invalid Cohort" unless @cohorts.include?(cohort)

    @conversions[cohort]
  end

  def confidence_interval(cohort)
    raise "Invalid Cohort" unless @cohorts.include?(cohort)

    ABAnalyzer.confidence_interval(@conversions[cohort], @visits[cohort], @confidence_interval)
  end

  def confidence_score
    tester = ABAnalyzer::ABTest.new ab_value_map

    1 - tester.chisquare_p
  end

  private

  def process(data)
    data.each do |row|
      cohort = row["cohort"]
      @cohorts << cohort unless @cohorts.include?(cohort)
      @conversions[cohort] ||= 0
      @visits[cohort] ||= 0
      @conversions[cohort] += row["result"]
      @visits[cohort] += 1
    end
  end

  def ab_value_map
    values = {}
    @conversions.each do |cohort, value|
      values[cohort] = {
        converted: value, not_converted: (@visits[cohort] - value)
      }
    end
    values
  end
end
