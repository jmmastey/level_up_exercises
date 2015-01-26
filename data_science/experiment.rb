require_relative 'json_parser'
require_relative 'cohort'

class Experiment
  attr_accessor :cohorts

  def initialize(data)
    @cohorts = data.map { |key, value| Cohort.new(key => value) }
  end

  def visits_for_experiment
    @cohorts.each_with_object({}) do |cohort, visits|
      visits[cohort.name] = cohort.visits
    end
  end

  def conversions_for_experiment
    @cohorts.each_with_object({}) do |cohort, conversions|
      conversions[cohort] = cohort.conversions
    end
  end

  def total_visits
    visits_for_experiment.values.inject(:+)
  end

  def total_conversions
    conversions_for_experiment.values.inject(:+)
  end

  def average_conversions
    total_conversions.to_f / total_visits
  end

  def expected_conversions
    @cohorts.each_with_object({}) do |cohort, expected_conversions|
      expected_conversions[cohort.name] = average_conversions * cohort.visits
    end
  end

  def expected_failures
    @cohorts.each_with_object({}) do |cohort, expected_failures|
      expected_failures[cohort.name] = (1 - average_conversions) * cohort.visits
    end
  end
end
