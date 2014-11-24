require 'abanalyzer'
require_relative 'dataparser.rb'

class Datacalculation
  attr_accessor :summary_hash
  Z_SCORE = 1.96

  def initialize(summary_hash)
    @summary_hash = summary_hash
  end

  def total_size(cohort)
    summary_hash[cohort][:total]
  end

  def number_of_conversion(cohort)
    summary_hash[cohort][:conversion]
  end

  def conversion_rate(cohort)
    summary_hash[cohort][:conversion] / summary_hash[cohort][:total]
  end

  def conversion_percentage(cohort)
    lower = (conversion_rate(cohort) - error_bars(cohort)) * 100
    higher = (conversion_rate(cohort) + error_bars(cohort)) * 100
    (lower.round(2)...higher.round(2))
  end

  def confidence_level
    ab_tester = ABAnalyzer::ABTest.new summary_hash
    (1.0 - ab_tester.chisquare_p).round(2)
  end

  private

  def standard_error(cohort)
    p = conversion_rate(cohort)
    Math.sqrt(p * (1 - p) / summary_hash[cohort][:total].to_i)
  end

  def error_bars(cohort)
    standard_error(cohort) * Z_SCORE
  end
end
