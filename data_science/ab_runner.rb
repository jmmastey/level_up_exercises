require 'pp'
require_relative 'split_test'
require_relative 'cohort_converter'

abort('Please include one json file as an argument.') unless ARGV.count == 1

converter = CohortConverter.new(ARGV[0])
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
