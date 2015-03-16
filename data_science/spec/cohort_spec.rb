require_relative "spec_helper"

describe Cohort do
  before :each do
    parser = FileParser.new("data_simple_test.json")
    cohort_data_a = parser.cohort_a
    cohort_data_b = parser.cohort_b
    @cohort_a = Cohort.new(cohort_data_a)
    @cohort_b = Cohort.new(cohort_data_b)
  end

  it "should count number of conversions (a)" do
    expect(@cohort_a.conversions).to eq(7)
  end
  it "should count number of non-conversions (a)" do
    expect(@cohort_a.non_conversions).to eq(20)
  end
  it "should calculate total sample size (a)" do
    expect(@cohort_a.sample_size).to eq(27)
  end
  it "should calculate conversion_rate (a)" do
    expect(@cohort_a.conversion_rate).to be_within(0.001).of(0.2593)
  end
  it "should calculate error bars for given conversion rate (a)" do
    expect(@cohort_a.error_bars).to eq([0.0940, 0.4246])
  end
  it "should count number of conversions (b)" do
    expect(@cohort_b.conversions).to eq(13)
  end
  it "should count number of non-conversions (b)" do
    expect(@cohort_b.non_conversions).to eq(11)
  end
  it "should calculate total sample size (b)" do
    expect(@cohort_b.sample_size).to eq(24)
  end
  it "should calculate conversion_rate (b)" do
    expect(@cohort_b.conversion_rate).to be_within(0.001).of(0.5417)
  end
  it "should calculate error bars for given conversion rate (b)" do
    expect(@cohort_b.error_bars).to eq([0.3423, 0.7410])
  end
end
