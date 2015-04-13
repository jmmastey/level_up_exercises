require_relative 'SplitTest'
require_relative 'split_test_data'
require 'pp'

abort('Please include one json file as an argument.') unless ARGV.count == 1

data = SplitTestData.new(ARGV[0]) #this runner is very lazy.
test = SplitTest.new(data)
successes = data.successes
attempts = data.attempts
conf_intervals = test.confidence

puts "Successes for each cohort: "
pp successes
puts "Attempts for each cohort: "
pp attempts
puts "95% of the time, the resulting proportion would be between these two numbers: "
pp conf_intervals
puts "Chi-Square: "

values = {}
attempts. 



test.


