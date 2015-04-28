require 'json'
require_relative './cohort.rb'
require_relative './ab_test.rb'
require_relative './data_parser.rb'

def print_cohort_info(cohort)
  interval = cohort.compute_confidence_interval_95pct
  conversion_rate = cohort.conversion_rate * 100
  printf("Cohort %s sample size: %d and conversions: %d \n", cohort.name,
                              cohort.sample_size, cohort.num_conversions)
  printf("Cohort %s conversion rate: %2.2f%% and " \
         "range %2.2f%% - %2.2f%% (at 95%% confidence). \n", cohort.name, \
         conversion_rate, interval[0] * 100, interval[1] * 100)
end

def print_cohort_comparison(compare)
  printf("Leading cohort is %s with %2.2f%% confidence. \n", compare.leader, \
                               compare.compute_leader_confidence_level * 100)
end

def build_list_of_cohorts(unique_cohorts, unique_cohorts_conversions)
  cohorts = []
  unique_cohorts.keys.each do |cohort_name|
    sample_size = unique_cohorts[cohort_name]
    num_conversions = unique_cohorts_conversions[cohort_name]
    new_cohort = Cohort.new(cohort_name, sample_size, num_conversions)
    cohorts.push(new_cohort)
  end
  cohorts
end

parsed_data = DataParser.new('data_export_2014_06_20_15_59_02.json')
all_cohorts = build_list_of_cohorts(parsed_data.unique_cohorts, parsed_data.unique_cohorts_conversions)

all_cohorts.each do |cohort|
  print_cohort_info(cohort)
end

compare = ABtest.new(all_cohorts[0], all_cohorts[1])
print_cohort_comparison(compare)
