require 'json'
require 'abanalyzer'
require_relative './cohort.rb'

class Analyzer
  PROBABILITY_LEVEL = 0.05
  attr_reader :file_name, :cohorts, :p_value

  def initialize(file_name)
    @file_name = file_name
  end

  def load_cohorts_from_data
    raw_data = JSON.parse(File.read(file_name))
    separated_cohort_data = separate_data_samples(raw_data)
    create_cohorts(separated_cohort_data)
  end

  def perform_experiment
    tester = initialize_test
    @p_value = tester.chisquare_p
  end

  def print_summary
    print_cohort_summary
    puts
    puts 'Test Results:'
    puts
    print_results
  end

  private

  def separate_data_samples(data)
    data.each_with_object({}) do |row, cohort_data|
      cohort_data[row['cohort']] ||= []
      cohort_data[row['cohort']] <<= row['result']
    end
  end

  def create_cohorts(grouped_cohort_data)
    grouped_cohort_data.each_pair.map do |name, sample_data|
      Cohort.new(name, sample_data).tap(&:calculate_statistics)
    end
  end

  def initialize_test
    @cohorts = load_cohorts_from_data
    values = cohorts.each_with_object({}) do |cohort, test_params|
      test_params[cohort.name] = cohort.conversion_statistics
    end
    ABAnalyzer::ABTest.new(values)
  end

  def print_results
    puts "P-value: #{p_value.round(4)}"
    if p_value < PROBABILITY_LEVEL
      puts 'There is a significant difference between the cohorts'
    else
      puts 'There is no significant difference between the cohorts'
    end
  end

  def print_cohort_summary
    puts 'Cohort Summary:'
    puts
    cohorts.each { |cohort| puts cohort.summary }
  end
end

# file_name = 'data_export_2014_06_20_15_59_02.json'
# analyzer = Analyzer.new(file_name)
# analyzer.load_cohorts_from_data
# analyzer.perform_experiment
# analyzer.print_summary
