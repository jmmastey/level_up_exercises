require 'pp'
require_relative 'split_test'
require_relative 'split_test_data'

abort('Please include one json file as an argument.') unless ARGV.count == 1

data = SplitTestData.new(ARGV[0]) #this runner is very lazy.
test = SplitTest.new(data)
successes = data.successes
attempts = data.attempts
conf_intervals = test.confidence
chi_square = test.chi_square

puts "Successes for each cohort: "
pp successes
puts "Attempts for each cohort: "
pp attempts
puts "95% of the time, the resulting proportion will be between..."
pp conf_intervals
puts "Probability that data at least as surprising as the observed sample " <<
"results would be generated under a model of random chance: "
pp chi_square

# ruby ab_runner.rb data_export_2014_06_20_15_59_02.json 
# > Successes for each cohort: 
# > {"B"=>79, "A"=>47}
# > Attempts for each cohort: 
# > {"B"=>1543, "A"=>1349}
# > 95% of the time, the resulting proportion will be between...
# > {"B"=>[0.04020173369400816, 0.06219619242394388],
# > "A"=>[0.025055087455844, 0.04462615791109446]}
# > Probability that data at least as surprising as the observed sample 
# > results would be generated under a model of random chance: 
# > 0.03156402546059378
