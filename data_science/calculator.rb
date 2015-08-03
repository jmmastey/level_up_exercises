require_relative('json_parser')
require('abanalyzer')

class Calculator
  attr_reader :data

  def load(filepath)
    @data = JSONParser.new.parse(filepath)
  end

  def conversion_rate(cohort)
    number_of_conversions(cohort).to_f / total_size(cohort).to_f
  end

  def total_size(cohort)
    @data.count { |entry| entry['cohort'] == cohort }
  end

  def number_of_conversions(cohort)
    @data.count { |entry| entry['result'] == 1 && entry['cohort'] == cohort }
  end

  def confidence_interval(cohort, confidence)
    successes = number_of_conversions(cohort)
    trials = total_size(cohort)
    ABAnalyzer.confidence_interval(successes, trials, confidence)
  end

  def chi_square_confidence
    values = { a: cohort_totals('A'), b: cohort_totals('B') }
    ab_test = ABAnalyzer::ABTest.new(values)
    ab_test.chisquare_p
  end

  def cohort_totals(cohort)
    { success: number_of_conversions(cohort), total: total_size(cohort)}
  end
end
