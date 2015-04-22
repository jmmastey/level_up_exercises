require 'json'
require_relative './cohort.rb'
require_relative './ABtest.rb'

def print_cohort_info(cohort)
  confidence_level = cohort.compute_confidence_interval_95pct
  conversion_rate = cohort.conversion_rate
  printf("Cohort %s conversion rate: %2.2f%% and " \
         "95%% confidence interval %2.2f%% - %2.2f%%. \n", cohort.name, \
          conversion_rate*100, confidence_level[0]*100, confidence_level[1]*100)
end

def print_cohort_comparison(compare)
  printf("Leading cohort is %s with %2.2f%% confidence. \n",compare.leader, \
                                 compare.compute_leader_confidence_level*100)
end
    





#data_file = File.read('data_export_2014_06_20_15_59_02.json')
data_file = File.read('new_data.json')
all_data = JSON.parse(data_file)

groupA = all_data.select { |record| record["cohort"] == "A" }
groupB = all_data.select { |record| record["cohort"] == "B" }

cohortA = Cohort.new(groupA)
cohortB = Cohort.new(groupB)

puts 'cohort A', cohortA.sample_size, cohortA.num_conversions
puts 'cohort B', cohortB.sample_size, cohortB.num_conversions
cohortA.num_conversions = 25

print_cohort_info(cohortA)
print_cohort_info(cohortB)

compare = ABtest.new(cohortA, cohortB)
print_cohort_comparison(compare)



