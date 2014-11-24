require_relative 'dataparser.rb'
require_relative 'datacalculation.rb'

cohort = Dataparser.new
cohort_summary_hash = cohort.load_json_file 'source_data.json'
conversion  = Datacalculation.new cohort_summary_hash
puts "Total sample size for cohort A: \t#{conversion.total_size('A')}"
puts "Total sample size for cohort B: \t #{conversion.total_size('B')}"
printf "Conversion rate for A:\t%.2f%%\n", conversion.conversion_rate('A') * 100
printf "Conversion rate for B:\t%.2f%%\n", conversion.conversion_rate('B') * 100
puts "Number of conversions for A: \t #{conversion.number_of_conversion('A')}"
puts "Number of conversions for B: \t #{conversion.number_of_conversion('B')}"
puts "Conversion percentage of A: \t #{conversion.conversion_percentage('A')}"
puts "Conversion percentage of B: \t #{conversion.conversion_percentage('B')}"
puts "Confidence level is:\t#{conversion.confidence_level}"
