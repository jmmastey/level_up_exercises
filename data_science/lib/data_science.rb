require_relative 'robo_researcher'

class DataScience
  attr_reader :researcher

  DATA_FILE = "data_export_2014_06_20_15_59_02.json"

  def initialize(researcher: nil)
    researcher ||= RoboResearcher.new(data_file: DATA_FILE)
    @researcher = researcher
  end

  def report
    puts "\n#{conclude}\n\n#{details}\n\n"
  end

  def conclude
    significance = researcher.significance_of_difference
    return conclude_significant(significance) if researcher.significant?
    "There is no significant difference between cohorts."
  end

  def conclude_significant(significance)
    best = researcher.best_cohort
    standardized_significance = stats_standard_significance(significance)
    "Cohort #{best.name} is better with 95% confidence.  The difference is " \
    "significant with #{standardized_significance}% confidence."
  end

  def stats_standard_significance(significance)
    return 99.99 if significance >= 99.99
    return 99.9 if significance >= 99.9
    return 99 if significance >= 99
    significance.round
  end

  def details
    researcher.to_s.join("\n")
  end
end

DataScience.new.report
