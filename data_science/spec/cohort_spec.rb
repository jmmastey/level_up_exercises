require 'spec_helper'

describe Cohort do
  let(:filename) { "test_data.json" }
  let(:data) { JSON.parse(File.read(filename)) }
  let(:cohort_name) { "A" }
  let(:cohort_data) do 
    data.select { |d| d["cohort"] == cohort_name }.map { |d| d["result"] }
  end
  let(:cohort) { Cohort.new(cohort_name, cohort_data) }

  describe "#initialize" do
    it "takes two parameters and returns a Cohort object" do
      expect(cohort).to be_a(Cohort)
      expect(cohort.name).to eq("A")
      expect(cohort.sample_size).to eq(30)
    end
  end

  describe "#calculate_conversion_rate" do
    it "should have a conversion rate of about 23.34%" do
      expect(cohort.calculate_conversion_rate).to be_within(0.01).of(0.234)
    end
  end

  describe "#calculate_standard_error" do
    it "should have a standard error of about 0.0772" do
      expect(cohort.calculate_standard_error).to be_within(0.01).of(0.0772)
    end
  end

  describe "#calculate_confidence_interval" do
    it "should have a confidence interval of about [0.156, 0.310]" do
      expect(cohort.calculate_confidence_interval[0])
        .to be_within(0.01).of(0.1558)
      expect(cohort.calculate_confidence_interval[1])
        .to be_within(0.01).of(0.3112)
    end
  end
end