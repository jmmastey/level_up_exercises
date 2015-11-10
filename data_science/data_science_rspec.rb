require './data_science'

describe "data_science" do
  let(:data_science) { DataScience.new('./data_export_2014_06_20_15_59_02.json') }

  let(:rates_calculated) do
    data_science.find_counts_per_cohort
    data_science.calculate_average_conversion_rate
    data_science.calculate_95_perc_conversion_rate_range
    data_science
  end

  let(:confidence_calculated) do
    data_science.find_counts_per_cohort
    data_science.calculate_average_conversion_rate
    data_science.calculate_95_perc_conversion_rate_range
    data_science.calculate_confidence_level
  end

  it "should parse the json file of the experiment", :happy do
    expect(data_science).to be_successfully_loaded
  end

  it "should fail at parsing nothing", :sad do
    expect { DataScience.new('') }.to raise_error(Errno::ENOENT)
  end

  it "should fail at parsing unexisting file", :sad do
    expect { DataScience.new('dfs') }.to raise_error(Errno::ENOENT)
  end

  it "should fail at parsing garbage", :bad do
    f = 'bullshit_data.json'
    expect { DataScience.new(f) }.to raise_error(JSON::ParserError)
  end

  it "should find visits and conversions count for each cohort", :happy do
    data_science.find_counts_per_cohort
    expect(data_science.cohort_a.count).not_to be_zero
    expect(data_science.cohort_b.count).not_to be_zero
    data_science
  end

  it "should give the conversion rate for each cohort", :happy do
    rates_calculated
    expect(data_science).to be_able_to_calculate_avg_conv_rate
    expect(data_science).to be_able_to_calculate_95_conv_rate_ranges
  end

  it "should compute the correct average rates for Cohort A & B" do
    rates_calculated
    expect(data_science.cohort_a.avg_rate).to be_within(0.0001).of(0.0348)
    expect(data_science.cohort_b.avg_rate).to be_within(0.0001).of(0.0512)
  end

  it "should compute the correct rates for Cohort A" do
    rates_calculated
    expect(data_science.cohort_a.rate_low).to be_within(0.0001).of(0.0251)
    expect(data_science.cohort_a.rate_high).to be_within(0.0001).of(0.0446)
  end

  it "should compute the correct rates for Cohort B" do
    rates_calculated
    expect(data_science.cohort_b.rate_low).to be_within(0.0001).of(0.0402)
    expect(data_science.cohort_b.rate_high).to be_within(0.0001).of(0.0622)
  end

  it "should give the confidence level ", :happy do
    confidence_calculated
    expect(data_science).to be_able_to_produce_confidence_level
  end

  it "should compute the correct confidence level" do
    confidence_calculated
    expect(data_science.confidence_level).to be_within(0.0001).of(0.031564)
  end
end
