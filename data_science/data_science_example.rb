require_relative('data_science.rb')

calculator = DataScience.new
calculator.load('data_export_2014_06_20_15_59_02.json')

puts 'Total Sample size (Cohort A)'
puts calculator.total_size('A')
puts 'Number of conversions (Cohort A)'
puts calculator.number_of_conversions('A')
puts 'Conversion Rate (Cohort A)'
puts calculator.conversion_rate('A')
puts 'Confidence interval with 95% confidence (Cohort A)'
confidence =  calculator.confidence_interval('A', 0.95)
puts "[#{confidence[0]}, #{confidence[1]}]", ''

puts 'Total Sample size (Cohort B)'
puts calculator.total_size('B')
puts 'Number of conversions (Cohort B)'
puts calculator.number_of_conversions('B')
puts 'Conversion Rate (Cohort B)'
puts calculator.conversion_rate('B')
puts 'Confidence interval with 95% confidence (Cohort B)'
confidence =  calculator.confidence_interval('B', 0.95)
puts "[#{confidence[0]}, #{confidence[1]}]", ''

puts 'Confidence leader is better than random (accept H_0 if <= 0.05)'
puts calculator.chi_square_confidence
