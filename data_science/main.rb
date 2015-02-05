require_relative 'calculator'

filepath = "test_data.json"

calculator = Calculator.new
calculator.setup_data(filepath)

sample_sizes = calculator.sample_size
conversions = calculator.conversions
conversion_rates = calculator.conversion_rates
confident = calculator.confident?

puts ["Cohort A has a sample size of #{sample_sizes[:A]}",
      "Cohort A has #{conversions[:A]} conversions",
      "Cohort A has a conversion rate between: #{conversion_rates[:A][0]} and #{conversion_rates[:A][1]}",
      "",
      "Cohort B has a sample size of #{sample_sizes[:B]}",
      "Cohort B has #{conversions[:B]} conversions",
      "Cohort B has a conversion rate between: #{conversion_rates[:B][0]} and #{conversion_rates[:B][1]}",
      ""].join("\n")

if confident
  puts "The two sets are statistically different enough to matter"
else
  puts "The two sets are not statistically different enough to matter"
end
