require 'json'
require_relative './cohort.rb'
require_relative './ab_compare.rb'
require_relative './data_parser.rb'

def print_cohort_info(cohort)
  interval = cohort.confidence_interval_95pct
  conversion_rate = cohort.conversion_rate * 100
  puts "Cohort #{cohort.name} sample size: #{"%d" % cohort.sample_size}" +
       " and conversions: #{"%d" % cohort.num_conversions}"
  puts "Cohort #{cohort.name} conversion rate: #{"%2.2f" % conversion_rate}% " +
       "and range #{"%2.2f" % (interval[0]*100)} - " + 
       "#{"%2.2f" % (interval[1]*100)}% (at 95% confidence)."
end

def print_cohort_comparison(compare)
  puts "Leading cohort is #{compare.leader} with #{"%2.2f" %(compare.compute_leader_confidence_level*100)}% confidence."
end

def build_list_of_cohorts(cohorts_sample_size, cohorts_num_conversions)
  cohorts = []
  cohorts_sample_size.each do |cohort_name, sample_size|
    num_conversions = cohorts_num_conversions[cohort_name]
    new_cohort = Cohort.new(cohort_name, sample_size, num_conversions)
    cohorts.push(new_cohort)
  end
  cohorts
end

parsed_data = DataParser.new('data_export_2014_06_20_15_59_02.json')
all_cohorts = build_list_of_cohorts(parsed_data.cohorts_sample_size, parsed_data.cohorts_num_conversions)

all_cohorts.each do |cohort|
  print_cohort_info(cohort)
end

compare = ABCompare.new(all_cohorts[0], all_cohorts[1])
print_cohort_comparison(compare)
