require "abanalyzer"
require_relative "data_analyzer"
require_relative "errors"

class ABStatistics

  attr_reader :cohort_data

  ERROR_MISSING_COHORT = "Specified cohort does not exist within dataset."

  def initialize(cohorts)
    @cohort_data = cohorts
  end

  def cohort_exists?(cohort_name)
    cohort_data[cohort_name].nil? == false
  end

  def cohort_sample_size(cohort_name)
    raise MissingCohortError, ERROR_MISSING_COHORT unless cohort_exists?(cohort_name)
    cohort_data[cohort_name].length
  end

  def cohort_sample_success(cohort_name)
    raise MissingCohortError, ERROR_MISSING_COHORT unless cohort_exists?(cohort_name)
    cohort_data[cohort_name].select { |result| result.to_i == 1 }.length
  end

  def cohort_conversion_rate(cohort_name)
    raise MissingCohortError, ERROR_MISSING_COHORT unless cohort_exists?(cohort_name)
    successes = cohort_sample_success(cohort_name)
    attempts  = cohort_sample_size(cohort_name)
    Float(successes) / Float(attempts) * 100
  end

  def cohort_totals(cohort_name)
    raise MissingCohortError, ERROR_MISSING_COHORT unless cohort_exists?(cohort_name)  
    { success: cohort_sample_success(cohort_name), total: cohort_sample_size(cohort_name) }
  end

  def cohort_confidence_rate(cohort_name, confidence_level = 0.95)
    raise MissingCohortError, ERROR_MISSING_COHORT unless cohort_exists?(cohort_name)
    successes = cohort_sample_success(cohort_name)
    attempts  = cohort_sample_size(cohort_name)
    ABAnalyzer.confidence_interval(successes, attempts, confidence_level)
  end

  def chi_square_confidence
    values  = { A: cohort_totals("A"), B: cohort_totals("B") }
    ab_test = ABAnalyzer::ABTest.new(values)
    ab_test.chisquare_p * 100
  end
end