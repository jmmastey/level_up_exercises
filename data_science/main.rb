# Runner for the Data Science exercise

require_relative 'json_loader'
require_relative 'dataset'

json = JSONLoader.new('source_data.json').fetch_data
dataset = Dataset.new(json)

total_a = dataset.total_in_group('A')
total_b = dataset.total_in_group('B')

conversions_a = dataset.number_of_conversions('A')
conversions_b = dataset.number_of_conversions('B')

puts "Total Sample Size: #{(total_a + total_b)}"
puts "\tGroup A: #{total_a}"
puts "\tGroup B: #{total_b}"
puts "Conversions"
puts "\tGroup A: #{conversions_a}"
puts "\tGroup B: #{conversions_b}"
puts "Percentage of Conversions"
puts "\tGroup A: #{dataset.percentage_of_conversion('A') * 100}"
puts "\tGroup B: #{dataset.percentage_of_conversion('B') * 100}"
puts "Confidence Level: #{dataset.calculate_probability}"
