require './ab_split_test'
require './parser'

data = ParsedData.new('data_export_2014_06_20_15_59_02.json')
ab_split = ABSplitTest.new(data)

puts "The conversion rate for #{ab_split.cohorts[0]} is #{ab_split.conversion_rate(ab_split.cohorts[0])}"
puts "The conversion rate for #{ab_split.cohorts[1]} is #{ab_split.conversion_rate(ab_split.cohorts[1])}"

puts "The confidence level is #{ab_split.confidence_score}"
