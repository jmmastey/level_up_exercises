require 'json'
require 'abanalyzer'
require_relative './cohort.rb'
require 'pry'

class Analyzer
  PROBABILITY_LEVEL = 0.05
  attr_accessor :file_name, :cohorts, :p_value

  def initialize(file_name)
    @file_name = file_name
  end

  def load_raw_data_from_file
    JSON.parse(File.read(@file_name))
  end

  def load_cohort_data(data)
    data.each_with_object({}) do |row, cohort_data|
      cohort_data[row['cohort']] ||= []
      cohort_data[row['cohort']] <<= row["result"]
    end
  end

  def build_cohort_array(cohort_data)
    cohort_data.each_pair.map do |name, sample_data|
      cohort = Cohort.new(name, sample_data)
      cohort.calculate_statistics
      cohort
    end
  end

  def convert_data_for_test
    raw_data = load_raw_data_from_file
    cohort_data = load_cohort_data(raw_data)
    build_cohort_array(cohort_data)
  end

  def initialize_test
    @cohorts = convert_data_for_test
    values = @cohorts.each_with_object({}) do |cohort, test_params|
      test_params[cohort.name] = cohort.conversion_statistics
    end
    ABAnalyzer::ABTest.new(values)
  end

  def perform_experiment
    tester = initialize_test
    @p_value = tester.chisquare_p
  end

  def print_summary
    print_cohort_summary
    puts
    puts "Test Results:"
    puts
    print_results
  end

  def print_results
    puts "P-value: #{@p_value.round(4)}"
    if @p_value < PROBABILITY_LEVEL
      puts "There is a significant difference between the cohorts"
    else
      puts "There is no significant difference between the cohorts"
    end
  end

  def print_cohort_summary
    puts "Cohort Summary:"
    puts
    @cohorts.each(&:print_summary)
  end
end

# file_name = 'data_export_2014_06_20_15_59_02.json'
# analyzer = Analyzer.new(file_name)
# analyzer.perform_experiment
# analyzer.print_summary
