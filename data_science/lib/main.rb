#!/usr/bin/ruby
require_relative 'cohort_data'
require_relative 'ab_tester'

FILENAME = "../data_export_2014_06_20_15_59_02.json"

begin
  data = CohortData.new(FILENAME)
  array_of_data = data.load_json_data_into_array
rescue
  puts "The file #{FILENAME} does not exist!"
end

tester = ABTester.new(array_of_data)

puts "Total sample size and number of conversions for each cohort:"
puts "Total size is:     #{tester.all_visits.size}"
puts "Size of cohort A:  #{tester.cohort_by_name('A').size}"
puts "Size of cohort B:  #{tester.cohort_by_name('B').size}"
print "Conversion rate for cohort a is "
puts "#{tester.conversion_rate(tester.cohort_by_name('A'))}"
print "Conversion rate for cohort b is "
puts "#{tester.conversion_rate(tester.cohort_by_name('B'))}"
print "Confidence level that the current leader is in fact better than random: "
puts tester.chi_square(tester.cohort_by_name('A'), tester.cohort_by_name('B'))
