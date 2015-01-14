require_relative "a_b_calculator.rb"
require_relative "cohort.rb"
require_relative "a_b_data_summary.rb"

puts "Example with source_data.json (B is winner):"
summary = ABDataSummary.new("../source_data.json")
a_cohort = Cohort.new(summary.a_conv, summary.a_nonconv)
b_cohort = Cohort.new(summary.b_conv, summary.b_nonconv)
a_b_test = ABCalculator.new(
  a_cohort.conversions, a_cohort.nonconvs,
  b_cohort.conversions, b_cohort.nonconvs
)
puts "A data: conversions: #{a_cohort.conversions}"
puts "A data: conversions: #{a_cohort.nonconvs}"
puts "B data: conversions: #{b_cohort.conversions}"
puts "B data: conversions: #{b_cohort.nonconvs}"
if a_b_test.different?
  puts "Samples are different at 0.05 significance"
  if a_cohort.conversion_rate > b_cohort.conversion_rate
    puts "A is winner"
  else
    puts "B is winner"
  end
end

puts "Confidence level: #{a_b_test.confidence_level}\n\n"

puts "Example with A as winner:"
a_cohort = Cohort.new(100, 51)
b_cohort = Cohort.new(51, 50)
a_b_test = ABCalculator.new(
  a_cohort.conversions, a_cohort.nonconvs,
  b_cohort.conversions, b_cohort.nonconvs
)
puts "A data: conversions: #{a_cohort.conversions}"
puts "A data: conversions: #{a_cohort.nonconvs}"
puts "B data: conversions: #{b_cohort.conversions}"
puts "B data: conversions: #{b_cohort.nonconvs}"
if a_b_test.different?
  puts "Samples are different at 0.05 significance"
  if a_cohort.conversion_rate > b_cohort.conversion_rate
    puts "A is winner"
  else
    puts "B is winner"
  end
end

puts "Confidence level: #{a_b_test.confidence_level}\n\n"

puts "Example with no winner:"
a_cohort = Cohort.new(52, 51)
b_cohort = Cohort.new(51, 52)
a_b_test = ABCalculator.new(
  a_cohort.conversions, a_cohort.nonconvs,
  b_cohort.conversions, b_cohort.nonconvs
)
puts "A data: conversions: #{a_cohort.conversions}"
puts "A data: conversions: #{a_cohort.nonconvs}"
puts "B data: conversions: #{b_cohort.conversions}"
puts "B data: conversions: #{b_cohort.nonconvs}"
if a_b_test.different?
  puts "Samples are different at 0.05 significance"
  if a_cohort.conversion_rate > b_cohort.conversion_rate
    puts "A is winner"
  else
    puts "B is winner"
  end
else
  puts "No winner at 0.05 significance"
end

puts "Confidence level: #{a_b_test.confidence_level}\n\n"
