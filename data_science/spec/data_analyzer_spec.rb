require_relative 'spec_helper'

describe DataAnalyzer do
  before :each do
    @data_analyzer = DataAnalyzer.new('test_data.json')
  end

  it "returns the correct sample size of each group" do
    expect(@data_analyzer.sample_size("A")).to eq(284)
    expect(@data_analyzer.sample_size("B")).to eq(359)
  end

  it "returns the correct number of conversions for a group" do
    expect(@data_analyzer.num_conversions("A")).to eq(13)
    expect(@data_analyzer.num_conversions("B")).to eq(23)
  end

  it "returns the correct number of fails for a group" do
    expect(@data_analyzer.num_fails("A")).to eq(271)
    expect(@data_analyzer.num_fails("B")).to eq(336)
  end

  it "returns the correct conversion rate" do
    expect(@data_analyzer.conversion_rate("A")).to eq(0.046)
    expect(@data_analyzer.conversion_rate("B")).to eq(0.064)
  end

  it "returns the correct standard error" do
    expect(@data_analyzer.standard_error("A")).to eq(0.012)
    expect(@data_analyzer.standard_error("B")).to eq(0.013)
  end

  it "returns the correct conclusion about confidence" do
    expect(@data_analyzer.better_than_random?).to be false
  end

  it "returns the correct range for the conversion rate" do
    a_cohort_range = @data_analyzer.conversion_rate_range("A")
    expect(a_cohort_range[0]).to eq(0.022)
    expect(a_cohort_range[1]).to eq(0.07)
    b_cohort_range = @data_analyzer.conversion_rate_range("B")
    expect(b_cohort_range[0]).to eq(0.039)
    expect(b_cohort_range[1]).to eq(0.089)
  end
end
