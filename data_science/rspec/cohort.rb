require '../cohort.rb'
require '../data_science.rb'

describe Cohort do
  before :all do
    data_file = '../data_export_2014_06_20_15_59_02.json'
    data_science = DataScience.new(data_file)
    @cohort_a = data_science.cohorts[0]
    @cohort_b = data_science.cohorts[1]
  end

  it "should calculate the correct sample size" do
    expect(@cohort_a.sample_size).to eq(1349)
    expect(@cohort_b.sample_size).to eq(1543)
  end

  it "should calculate the correct cohort conversions" do
    expect(@cohort_a.conversions).to eq(47)
    expect(@cohort_b.conversions).to eq(79)
  end

  it "should calculate the correct conversion rate" do
    diff_a = (@cohort_a.conversion_rate - 0.0348).abs
    expect(diff_a).to be <= 0.0001

    diff_b = (@cohort_b.conversion_rate - 0.0512).abs
    expect(diff_b).to be <= 0.0001
  end

  it "should calculate the correct standard error" do
    diff_a = (@cohort_a.standard_error - 0.004993).abs
    expect(diff_a).to be <= 0.00001

    diff_b = (@cohort_b.standard_error - 0.005611).abs.abs
    expect(diff_b).to be <= 0.00001
  end

  it "should calculate the correct confidence intervals" do
    expect(@cohort_a.ci_low).to eq(0.025)
    expect(@cohort_a.ci_high).to eq(0.045)

    expect(@cohort_b.ci_low).to eq(0.04)
    expect(@cohort_b.ci_high).to eq(0.062)
  end
end
