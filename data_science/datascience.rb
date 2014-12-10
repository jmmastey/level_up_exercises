require_relative 'dataparser.rb'
require_relative 'datacalculation.rb'

parser = DataParser.new('source_data.json')
parser.load_json_file
results = DataCalculation.new(parser.summary)
puts "Total sample size for cohort A: \t#{results.total_size('A')}"
puts "Total sample size for cohort B: \t #{results.total_size('B') }"
printf "Conversion rate for A:\t%.2f%%\n", results.conversion_rate('A') * 100
printf "Conversion rate for B:\t%.2f%%\n", results.conversion_rate('B') * 100
puts "Number of conversions for A: \t #{results.number_of_conversion('A')}"
puts "Number of conversions for B: \t #{results.number_of_conversion('B')}"
puts "Confidence interval of A: \t #{results.confidence_interval('A')}"
puts "Confidence interval of B: \t #{results.confidence_interval('B')}"
puts "Confidence level is:\t#{results.confidence_level}"
