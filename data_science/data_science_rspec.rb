require './data_science'

describe data_science do
  it "should parse the json file of the experiment", :happy do
    data_science = data_science.new

    data_science.parse_json_file('./data_export_2014_06_20_15_59_02.json')

    expect(data_science).to be_successfully_loaded
  end

  it "should fail at parsing nothing", :sad do
    data_science = data_science.new

    expect { data_science.parse_json_file('') }.to raise_error(Errno::ENOENT)

    expect(data_science).not_to be_successfully_loaded
  end

  it "should fail at parsing unexisting file", :sad do
    data_science = data_science.new

    expect { data_science.parse_json_file('dfs') }.to raise_error(Errno::ENOENT)
  end

  it "should fail at parsing garbage", :bad do
    data_science = data_science.new

    f = 'bullshit_data.json'
    expect { data_science.parse_json_file(f) }.to raise_error(JSON::ParserError)
  end

   it "should find visits and conversions count for each cohort", :happy do
     data_science = data_science.new

    data_science.parse_json_file('./data_export_2014_06_20_15_59_02.json')
     data_science.find_counts_per_cohort

     expect(data_science).to be_able_to_find_cohort_counts
     data_science
   end

   it "should give the conversion rate for each cohort", :happy do
    data_science = data_science.new

    data_science.parse_json_file('./data_export_2014_06_20_15_59_02.json')
    data_science.find_counts_per_cohort

    data_science.calculate_average_conversion_rate
    data_science.calculate_95_perc_conversion_rate_range("A")
    data_science.calculate_95_perc_conversion_rate_range("B")
    expect(data_science).to be_able_to_calculate_avg_conv_rate
    expect(data_science).to be_able_to_calculate_95_conv_rate_ranges
   end

   it "should give the confidence level ", :happy do
     data_science = data_science.new

     data_science.parse_json_file('./data_export_2014_06_20_15_59_02.json')
     data_science.find_counts_per_cohort

     data_science.calculate_average_conversion_rate
     data_science.calculate_95_perc_conversion_rate_range("A")
     data_science.calculate_95_perc_conversion_rate_range("B")

     data_science.calculate_confidence_level

     expect(data_science).to be_able_to_produce_confidence_level
   end
end
