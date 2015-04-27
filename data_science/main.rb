require 'json'
require_relative './cohort.rb'
require_relative './ab_test.rb'

def print_cohort_info(cohort)
  interval = cohort.compute_confidence_interval_95pct
  conversion_rate = cohort.conversion_rate * 100
  printf("Cohort %s sample size: %d and conversions: %d \n",cohort.name, 
        cohort.sample_size, cohort.num_conversions)
  printf("Cohort %s conversion rate: %2.2f%% and " \
         "range %2.2f%% - %2.2f%% (at 95%% confidence). \n", cohort.name, \
         conversion_rate, interval[0] * 100, interval[1] * 100)
end

def print_cohort_comparison(compare)
  printf("Leading cohort is %s with %2.2f%% confidence. \n", compare.leader, \
                               compare.compute_leader_confidence_level * 100)
end

data_file = File.read('data_export_2014_06_20_15_59_02.json')
all_data = JSON.parse(data_file)

group_a = all_data.select { |record| record["cohort"] == "A" }
group_b = all_data.select { |record| record["cohort"] == "B" }

cohort_a = Cohort.new(group_a)
cohort_b = Cohort.new(group_b)

print_cohort_info(cohort_a)
print_cohort_info(cohort_b)

compare = ABtest.new(cohort_a, cohort_b)
print_cohort_comparison(compare)
