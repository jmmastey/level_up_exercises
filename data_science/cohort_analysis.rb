require 'abanalyzer'
require_relative 'load_json'
require_relative 'cohort_sorter'

class CohortAnalysis
  attr_accessor :cohort_sorter

  PROBABILITY_THRESHOLD = 0.05

  def initialize(*file_names)
    raise 'No file names provided' if file_names.empty?
    visits = file_names.map { |file_name| LoadJSON.new(file_name).parse }
    @cohort_sorter = CohortSorter.new(visits.flatten)
  end

  def winner
    winner? ? "Group '#{highest_conversion_group}' wins" : "No clear winner"
  end

  private

  def winner?
    cohort_differential <= PROBABILITY_THRESHOLD
  end

  def highest_conversion_group
    cohort_sorter.sorted_cohorts_by_conversion.last.group_name
  end

  def cohort_differential
    ABAnalyzer::ABTest.new(cohort_sorter.success_failures).chisquare_p
  end
end
