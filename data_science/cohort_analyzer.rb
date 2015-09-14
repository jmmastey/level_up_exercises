require "abanalyzer"
require_relative "file_parser"
require_relative "errors"

class CohortAnalyzer
  attr_accessor :confidence_level
  attr_reader :cohort_a, :cohort_b

  ERROR_MISSING_COHORT = "Specified cohort does not exist within dataset."

  def initialize(cohort_a, cohort_b)
    @confidence_level = 0.95
    @cohort_a = cohort_a
    @cohort_b = cohort_b
  end

  def attempts
    { A: cohort_a.count, B: cohort_b.count }
  end

  def successes
    { A: cohort_a.count(1), B: cohort_b.count(1) }
  end

  def conversion_rates
    {
      A: (successes[:A].to_f / attempts[:A].to_f) * 100,
      B: (successes[:B].to_f / attempts[:B].to_f) * 100,
    }
  end

  def confidence_intervals
    { A: confidence_of(:A), B: confidence_of(:B) }
  end

  def chi_square_confidence
    values  = { A: details_of(:A), B: details_of(:B) }
    ABAnalyzer::ABTest.new(values).chisquare_p * 100
  end

  private

  def confidence_of(data_key)
    ABAnalyzer.confidence_interval(successes[data_key], attempts[data_key], confidence_level)
  end

  def details_of(data_key)
    {
      success: successes[data_key],
      total: attempts[data_key],
    }
  end
end
