require '../cohort.rb'
require '../data_science.rb'

describe Cohort do
  let(:data_science) do
    data_file = '../data_export_2014_06_20_15_59_02.json'
    DataScience.new(data_file)
  end
  let(:cohort_a) { data_science.cohorts[0] }
  let(:cohort_b) { data_science.cohorts[1] }

  let(:cohort_a_ci) { cohort_a.confidence_interval }
  let(:cohort_b_ci) { cohort_b.confidence_interval }

  it "should calculate the correct sample size" do
    expect(cohort_a.sample_size).to eq(1349)
    expect(cohort_b.sample_size).to eq(1543)
  end

  it "should calculate the correct cohort conversions" do
    expect(cohort_a.conversions).to eq(47)
    expect(cohort_b.conversions).to eq(79)
  end

  it "should calculate the correct conversion rate" do
    expect(cohort_a.conversion_rate).to be_within(0.0001).of(0.0348)
    expect(cohort_b.conversion_rate).to be_within(0.0001).of(0.0512)
  end

  it "should calculate the correct standard error" do
    expect(cohort_a.standard_error).to be_within(0.00001).of(0.004993)
    expect(cohort_b.standard_error).to be_within(0.00001).of(0.005611)
  end

  it "should calculate the correct confidence intervals" do
    expect(cohort_a_ci[:low]).to eq(0.025)
    expect(cohort_a_ci[:high]).to eq(0.045)

    expect(cohort_b_ci[:low]).to eq(0.04)
    expect(cohort_b_ci[:high]).to eq(0.062)
  end
end
