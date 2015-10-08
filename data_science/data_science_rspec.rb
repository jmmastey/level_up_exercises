require './data_science'

describe DataScience do

	it "should parse the json file of the experiment" do 
		dataScience = DataScience.new

		dataScience.parse_json_file('./data_export_2014_06_20_15_59_02.json')

		expect(dataScience).to be_successfully_loaded
	end

 	it "should find the total number of visits and conversions for each cohort" do
 		dataScience = DataScience.new

		dataScience.parse_json_file('./data_export_2014_06_20_15_59_02.json')
 		dataScience.find_counts_per_cohort

 		expect(dataScience).to be_able_to_find_cohort_counts
 		dataScience
 	end

 	it "should give the conversion rate for each cohort" do
		dataScience = DataScience.new

		dataScience.parse_json_file('./data_export_2014_06_20_15_59_02.json')
		dataScience.find_counts_per_cohort

		dataScience.calculate_average_conversion_rate
		dataScience.calculate_95_perc_conversion_rate_range("A")
		dataScience.calculate_95_perc_conversion_rate_range("B")
		expect(dataScience).to be_able_to_calculate_avg_conv_rate
		expect(dataScience).to be_able_to_calculate_95_conv_rate_ranges
 	end

 	it "should give the confidence level about current leader being better than random" do
 		dataScience = DataScience.new

 		dataScience.parse_json_file('./data_export_2014_06_20_15_59_02.json')
 		dataScience.find_counts_per_cohort

 		dataScience.calculate_average_conversion_rate
 		dataScience.calculate_95_perc_conversion_rate_range("A")
		dataScience.calculate_95_perc_conversion_rate_range("B")

 		dataScience.calculate_confidence_level

 		expect(dataScience).to be_able_to_produce_confidence_level
 	end

end