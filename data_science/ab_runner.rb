require 'pp'
require_relative 'split_test'
require_relative 'cohort_converter'

abort('Please include one json file as an argument.') unless ARGV.count == 1

converter = CohortConverter.new(ARGV[0]) #this runner is very lazy.
cohorts = converter.cohorts
test = SplitTest.new(cohorts)

successes = cohorts.each_with_object(Hash.new) { |cohort, memo| memo[cohort.name] = cohort.successes }
attempts = cohorts.each_with_object(Hash.new) { |cohort, memo| memo[cohort.name] = cohort.attempts }

puts 'Successes for each cohort: '
pp successes
puts 'Attempts for each cohort: '
pp attempts
puts 'Conversion rates: '
pp test.conversion_rates
puts '95% of the time, the resulting proportion will be between...'
pp test.confidence
puts 'Probability that data at least as surprising as the observed sample ' <<
         'results would be generated under a model of random chance: '
pp test.chi_square

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
