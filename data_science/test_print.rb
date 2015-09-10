require_relative "data_analyzer"
require_relative "ab_statistics"
require_relative "errors"

ab_cohort = DataAnalyzer.new("data_export_2014_06_20_15_59_02.json").parse_data
ab_stats  = ABStatistics.new(ab_cohort)

puts "*" * 80

puts "-- (Cohort A) Size --"
puts ab_stats.cohort_sample_size("A")

puts "-- (Cohort A) Conversions --"
puts ab_stats.cohort_sample_success("A")

puts "-- (Cohort A) Conversion Rate % --"
puts ab_stats.cohort_conversion_rate("A")

puts "-- (Cohort A) Confidence Interval w/ 95% confidence --"
cohort_a_confidence = ab_stats.cohort_confidence_rate("A")
puts "[#{cohort_a_confidence[0]}, #{cohort_a_confidence[1]}]"

puts "-" * 20

puts "-- (Cohort B) Size --"
puts ab_stats.cohort_sample_size("B")

puts "-- (Cohort B) Conversions --"
puts ab_stats.cohort_sample_success("B")

puts "-- (Cohort B) Conversion Rate % --"
puts ab_stats.cohort_conversion_rate("B")

puts "-- (Cohort B) Confidence Interval w/ 95% confidence --"
cohort_a_confidence = ab_stats.cohort_confidence_rate("B")
puts "[#{cohort_a_confidence[0]}, #{cohort_a_confidence[1]}]"

printf "\n"
printf "-" * 10
printf " ***** "
printf "-" * 10

puts "\n-- CHI Square Confidence That Is <= 5% accurate --"
puts ab_stats.chi_square_confidence