require 'spec_helper'

describe Cohort do
  let(:filename) { "test_data.json" }
  let(:data) { JSON.parse(File.read(filename)) }
  let(:cohort_name) { "A" }
  let(:cohort_data) do
    data.select { |d| d["cohort"] == cohort_name }.map { |d| d["result"] }
  end
  let(:cohort) { Cohort.new(cohort_name, cohort_data) }
  let(:conversion_stats) { cohort.conversion_stats }

  describe "#initialize" do
    it "takes two parameters and returns a Cohort object", happy: true do
      expect(cohort).to be_a(Cohort)
      expect(cohort.name).to eq("A")
      expect(cohort.sample_size).to eq(30)
    end
  end

  describe "#calculate_conversion_rate" do
    it "should have a conversion rate of about 23.34%", happy: true do
      expect(cohort.calculate_conversion_rate).to be_within(0.01).of(0.234)
    end
  end

  describe "#calculate_standard_error" do
    it "should have a standard error of about 0.0772", happy: true do
      expect(cohort.calculate_standard_error).to be_within(0.01).of(0.0772)
    end
  end

  describe "#calculate_confidence_interval" do
    it "should have a confidence interval of [0.156, 0.310]", happy: true do
      expect(cohort.calculate_confidence_interval[0])
        .to be_within(0.01).of(0.1558)
      expect(cohort.calculate_confidence_interval[1])
        .to be_within(0.01).of(0.3112)
    end
  end

  describe "#conversion_stats" do
    it "should return a hash with the conversion stats", happy: true do
      expect(conversion_stats).to be_a(Hash)
      expect(conversion_stats.size).to eq(2)
      expect(conversion_stats[:converts]).to eq(7)
      expect(conversion_stats[:nonconverts]).to eq(23)
    end
  end
end
