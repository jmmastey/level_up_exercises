require 'ABAnalyzer'
require_relative "json_parser"

class DataScience
  attr_reader :total_samples, :conversions

  def initialize(data)
    @data = data
    @ab_analyzer = ABAnalyzer::ABTest.new(data)
  end

  def total_samples(cohort_name)
    variation = @data[cohort_name]
    variation[:total_samples]
  end

  def conversions(cohort_name)
    variation = @data[cohort_name]
    variation[:conversions]
  end

  def conversion_rate(cohort_name)
    (conversions(cohort_name) / total_samples(cohort_name)).round(3)
  end

  def distribution_range(cohort_name)
    rate = conversion_rate(cohort_name)
    sample_mean = error_bars(cohort_name)
    [(rate - sample_mean).round(3), (rate + sample_mean).round(3)]
  end

  def chisquare_p
    (1.0 - @ab_analyzer.chisquare_p).round(3)
  end

  def leader(cohort_name_a, cohort_name_b)
    variation_a_rate = conversion_rate(cohort_name_a)
    variation_b_rate = conversion_rate(cohort_name_b)
    variation_a_rate > variation_b_rate ? cohort_name_a : cohort_name_b
  end

  private

  def standard_error(cohort_name)
    variation = @data[cohort_name]
    p = conversion_rate(cohort_name)
    numerator = p * (1 - p)
    Math.sqrt((numerator / variation[:total_samples]))
  end

  def error_bars(cohort_name)
    standard_error(cohort_name) * 1.96
  end
end
