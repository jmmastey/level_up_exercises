require_relative('json_parser')
require('abanalyzer')

class DataScience
  def load(filepath)
    @parser = JSONParser.new
    @data = @parser.parse(filepath)
  end

  def data_reader
    @data
  end

  def conversion_rate(cohort)
    number_of_conversions(cohort).to_f / total_size(cohort).to_f
  end

  def total_size(cohort)
    @data.count { |entry| entry['cohort'] == cohort }
  end

  def number_of_conversions(cohort)
    conversions = 0
    @data.each do |entry|
      conversions += 1 if entry['result'] == 1 && entry['cohort'] == cohort
    end
    conversions
  end

  def confidence_interval(cohort, confidence)
    successes = number_of_conversions(cohort)
    trials = total_size(cohort)
    ABAnalyzer.confidence_interval(successes, trials, confidence)
  end

  def chi_square_confidence
    values = {}
    values[:a] = { success: number_of_conversions('A'), total: total_size('A') }
    values[:b] = { success: number_of_conversions('B'), total: total_size('B') }
    ab_test = ABAnalyzer::ABTest.new(values)
    ab_test.chisquare_p
  end
end
