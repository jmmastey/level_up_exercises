require_relative 'ab_data_parser'
require_relative 'ab_test_data'
require_relative 'probability_alpha_table'
require_relative 'chi_square_test'
require 'abanalyzer'

ab_data_parser = ABDataParser.new
arguments = { file_name: 'source_data.json', variant_key: 'cohort',
              result_key: 'result' }
ab_test_datas = ab_data_parser.parse_data(arguments)

ab_test_a = ABTestData.new(ab_test_datas[:A])
ab_test_b = ABTestData.new(ab_test_datas[:B])
printf "\n========== A/B Splite Test & Chi-Square Test ==========\n"
puts 'Variant : A'
printf "Total Samples : %d\n", ab_test_a.total_samples
printf "Conversions : %d\n\n", ab_test_a.conversions

puts 'Variant : B'
printf "Total Samples : %d\n", ab_test_b.total_samples
printf "Conversions : %d\n", ab_test_b.conversions

printf "=======================================================\n\n"

ab_test_a_range = ab_test_a.distribution_range
ab_test_b_range = ab_test_b.distribution_range

puts 'Variant A'
printf "Conversion Rate is %.2f%\n", (ab_test_a.conversion_rate * 100)
printf "The conversion rate range is [ %.2f%% , %.2f%% ]\n",
  (ab_test_a_range[0] * 100), (ab_test_a_range[1] * 100)
printf("Standard Error of A is %f\n\n", ab_test_a.standard_error)

puts 'Variant B'
printf "Conversion Rate of B is %.2f%\n", (ab_test_b.conversion_rate * 100)
printf "The conversion rate range is [ %.2f%% , %.2f%% ]\n",
  (ab_test_b_range[0] * 100), (ab_test_b_range[1] * 100)
printf("Standard Error of B is %f\n\n", ab_test_b.standard_error)

if ab_test_a.conversion_rate == ab_test_b.conversion_rate
  puts 'There is not winner'
else
  printf("The winner is %s\n",
    (ab_test_a.conversion_rate > ab_test_b.conversion_rate ? 'A' : 'B'))
end

puts
chi_square = ChiSquareTest.calculate(ab_test_a, ab_test_b)
puts "Chi Squrt x^2 is #{chi_square}"

significant_level = ProbabilityAlphaTable.significant_level(1, chi_square)
puts 'The significant level is #{significant_level}'
printf "The confidence level for this result is %.2f%\n",
  ((1 - significant_level) * 100)

printf "The significant different : %s\n",
  significant_level <= 0.5 ? 'Yes' : 'No'
