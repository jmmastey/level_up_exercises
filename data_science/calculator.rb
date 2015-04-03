require 'ABAnalyzer'
require_relative 'parser.rb'

class Calculator
  DECIMAL_PLACES = 4

  def initialize(data_file)
    @data = Parser.parse(data_file)
  end

  def sample_size(cohort)
    @data.count { |sample| sample.cohort == cohort }
  end

  def conversions(cohort)
    @data.count { |sample| sample.cohort == cohort && sample.result == 1 }
  end

  def conversion_rate(cohort)
    (conversions(cohort).to_f / sample_size(cohort)).round(DECIMAL_PLACES)
  end

  def standard_error(cohort)
    p = conversion_rate(cohort)
    n = sample_size(cohort)
    Math.sqrt(p * (1 - p) / n).round(DECIMAL_PLACES)
  end

  def distribution_range(cohort)
    p = conversion_rate(cohort)
    e = (standard_error(cohort) * 1.96).round(DECIMAL_PLACES)
    [(p - e).round(DECIMAL_PLACES), (p + e).round(DECIMAL_PLACES)]
  end

  def ab_analyzer_data
    values = {}
    @data.uniq(&:cohort).each do |sample|
      values[sample.cohort] ||= {
        success: conversions(sample.cohort),
        failure: (sample_size(sample.cohort) - conversions(sample.cohort)) }
    end
    values
  end

  def confidence_level
    tester = ABAnalyzer::ABTest.new ab_analyzer_data
    (1 - tester.chisquare_p).round(4) * 100
  end
end
