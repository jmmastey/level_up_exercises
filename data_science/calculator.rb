require_relative 'test_data_list'
require 'abanalyzer'
class Calculator
  attr_accessor :test_data_list

  def initialize
    @test_data_list = TestDataList.new
  end

  def setup_data(filepath)
    test_data_list.parse(filepath)
  end

  def conversions
    keys = get_cohorts(test_data_list)
    Hash[keys.map { |key| [key.to_sym, cohort_conversions(key)] }]
  end

  def conversion_rates
    keys = get_cohorts(test_data_list)
    Hash[keys.map { |key| [key.to_sym, cohort_rates(key)] }]
  end

  def sample_size
    keys = get_cohorts(test_data_list)
    Hash[keys.map { |key| [key.to_sym, cohort_sample_size(key)] }]
  end

  def cohort_conversions(cohort)
    converted_results = test_data_list.select { |data| data.result == 1 }
    converted_results.select { |result| result.cohort == cohort }.count
  end

  def cohort_rates(cohort)
    sample_size = cohort_sample_size(cohort)
    conversions = cohort_conversions(cohort)
    rates = ABAnalyzer.confidence_interval(conversions, sample_size, 0.95)

    rates.map { |x| (x * 100).round(2).to_s + '%' }
  end

  def cohort_sample_size(cohort)
    test_data_list.select { |result| result.cohort == cohort }.count
  end

  def get_cohorts(results_set)
    results_set.map(&:cohort).uniq { |x| x }
  end

  def confident?
    keys = get_cohorts(test_data_list)

    values = {}
    values[:agroup] = setup_confidence_hash(keys.first)
    values[:bgroup] = setup_confidence_hash(keys.last)

    ABAnalyzer::ABTest.new(values).different?
  end

  def setup_confidence_hash(cohort)
    {
      visitors: cohort_sample_size(cohort),
      converted: cohort_conversions(cohort),
    }
  end
end
