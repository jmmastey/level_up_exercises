require_relative "file_parser"
require_relative "cohort_analyzer"
require_relative "errors"

cohort_data = FileParser.parse_data("data_export_2014_06_20_15_59_02.json")
cohort_analysis = CohortAnalyzer.new(cohort_data["A"], cohort_data["B"])

puts "*" * 80

puts "-- Cohort Total Attempts --"
puts cohort_analysis.attempts.to_s

puts "-- Cohort Total Successes --"
puts cohort_analysis.successes.to_s

puts "-- Cohort Conversion Rates (%) --"
puts cohort_analysis.conversion_rates.to_s

puts "-- Confidence Intervals w/ 95% confidence --"
puts cohort_analysis.confidence_intervals.to_s

printf "\n"
printf "-" * 10
printf " ***** "
printf "-" * 10

puts "\n-- CHI Square Confidence (%) --"
puts cohort_analysis.chi_square_confidence
