require_relative 'spec_helper'

describe Cohort do
  let(:cohort_a) { Cohort.new("A", JSONReader.read_file('test_data.json')) }
  let(:cohort_b) { Cohort.new("B", JSONReader.read_file('test_data.json')) }
  let(:sample_size_a) { 284 }
  let(:sample_size_b) { 359 }
  let(:conversions_a) { 13 }
  let(:conversions_b) { 23 }
  let(:fails_a) { 271 }
  let(:fails_b) { 336 }
  let(:conversion_rate_a) { 0.046 }
  let(:conversion_rate_b) { 0.064 }

  it "returns the correct sample size of each group" do
    expect(cohort_a.sample_size).to eq(sample_size_a)
    expect(cohort_b.sample_size).to eq(sample_size_b)
  end

  it "returns the correct number of conversions for a group" do
    expect(cohort_a.conversions).to eq(conversions_a)
    expect(cohort_b.conversions).to eq(conversions_b)
  end

  it "returns the correct number of fails for a group" do
    expect(cohort_a.fails).to eq(fails_a)
    expect(cohort_b.fails).to eq(fails_b)
  end

  it "returns the correct conversion rate" do
    expect(cohort_a.conversion_rate).to eq(0.046)
    expect(cohort_b.conversion_rate).to eq(0.064)
  end

  it "returns the correct standard error" do
    expect(cohort_a.standard_error).to eq(0.012)
    expect(cohort_b.standard_error).to eq(0.013)
  end

  it "returns the correct range for the conversion rate" do
    a_cohort_range = cohort_a.conversion_rate_range
    expect(a_cohort_range[0]).to eq(0.022)
    expect(a_cohort_range[1]).to eq(0.07)
    b_cohort_range = cohort_b.conversion_rate_range
    expect(b_cohort_range[0]).to eq(0.039)
    expect(b_cohort_range[1]).to eq(0.089)
  end

  context "The cohort is empty" do
    let(:empty_cohort) { Cohort.new("C", {}) }

    it "returns the correct converstion rate if sample size is zero" do
      expect(empty_cohort.conversion_rate).to eq(0)
    end

    it "returns the correct standard error if sample size is zero" do
      expect(empty_cohort.standard_error).to eq(0)
    end

    it "returns the correct range if sample size is zero" do
      expect(empty_cohort.conversion_rate_range[0]).to eq(0)
      expect(empty_cohort.conversion_rate_range[1]).to eq(0)
    end
  end
end
