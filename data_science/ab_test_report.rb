require_relative 'ab_data_parser'
require_relative 'ab_analyzer'
json_obj = File.read('source_data.json')
test_datas = ABDataParser.read(json_obj, 'cohort', 'result')

variations = test_datas.keys
variation_a_name = variations[0].to_sym
variation_b_name = variations[1].to_sym

data_a = test_datas[variations[0]]
data_b = test_datas[variations[1]]

analizer = ABAnalyzer.new(test_datas)

printf "Groupd %s\n", variations[0]
printf "  - Total samples       : %d\n", data_a[:total_samples]
printf "  - Conversions         : %d\n", data_a[:conversions]
printf "  - Conversion rate     : %.2f%%\n",
  analizer.conversion_rate(variation_a_name)
printf "  - Distribution range  : (%.2f%% ... %.2f%%)\n",
  *analizer.distribution_range(variation_a_name)

printf "Groupd %s\n", variations[1]
printf "  - Total samples       : %d\n", data_b[:total_samples]
printf "  - Conversions         : %d\n", data_b[:conversions]
printf "  - Conversion rate     : %.2f%%\n",
  analizer.conversion_rate(variation_b_name)
printf "  - Distribution range  : (%.2f%% ... %.2f%%)\n",
  *analizer.distribution_range(variation_b_name)

printf "The winner : %s\n", analizer.winner
printf "The confidence level for the result : %.0f%%\n",
  analizer.confidence_level
