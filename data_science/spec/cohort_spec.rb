require 'spec_helper'
require_relative '../cohort.rb'

describe Cohort do
  let(:data)              { JSONParser.read_data("sample.json") }
  let(:data_A)            { data.select { |hash| hash['cohort'] == 'A' } }
  let(:cohort_A)          { Cohort.new(data_A) }
  let(:conversion_rate_A) { 5 / 14.0 }
  let(:sample_size_A)     { 14 }
  let(:standard_error_A)  { conversion_rate_A * (1 - conversion_rate_A) / sample_size_A }

  describe '#sample_size' do
    it "should return total sample size for cohort_A" do
      expect(cohort_A.sample_size).to eq(sample_size_A)
    end
  end

  describe '#conversions' do
    let(:num_converted_A) { 5 }

    it "should return results with 1 for cohort_A" do
      expect(cohort_A.conversions).to eq(num_converted_A)
    end
  end

  describe '#conversion_rate' do
    it "should return conversion rate for cohort_A" do
      expect(cohort_A.conversion_rate).to eq(conversion_rate_A)
    end
  end

  describe '#standard_error' do
    it "should return standard error for cohort_A" do
      expect(cohort_A.standard_error).to eq(standard_error_A)
    end
  end

  describe '#conversion_rate_range' do
    let(:cr_range_A) { [0.32434402332361517, 0.38994169096209913] }

    it "should return the conversion rate range for cohort_A" do
      expect(cohort_A.conversion_rate_range).to eq(cr_range_A)
    end
  end

  describe '#bounced' do
    let(:num_bounced_A) { 9 }

    it "should return results with 0 for cohort_A" do
      results = cohort_A.bounced
      expect(results).to eq(num_bounced_A)
    end
  end
end
