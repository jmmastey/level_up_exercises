require_relative '../a_b_split_tester.rb'
require_relative '../data_loader.rb'
require 'rspec'

RSpec.describe ABSplitTester do

  let(:data) { DataLoader.new('ab_test_data.json') }
  let(:ab_split_tester) { ABSplitTester.new(data.value) }

  describe "#total_size" do
    it "returns 44 for our test data" do
      expect(data.total_size).to eq(44)
    end
  end

  describe "#cohorts_count" do
    it "returns 2 cohorts count for data" do
      expect(ab_split_tester.cohorts_count).to eq(2)
    end
  end

  describe "#conversion_count" do
    it "returns the number of conversions for a given cohort" do
      expect(ab_split_tester.conversion_count("A")).to eq(9)
      expect(ab_split_tester.conversion_count("B")).to eq(17)
    end
  end

  describe "#confidence_interval" do
    it "returns the count of rows where result is 1" do
      ab_split_tester.confidence_interval("A").each do |interval|
        expect(interval).to be_within(1).of(0.43)
      end
      ab_split_tester.confidence_interval("B").each do |interval|
        expect(interval).to be_within(0.19).of(0.74)
      end
    end
  end

  describe "Accept or reject Null Hypothesis that Current leader is better" do
    it "checks if confidence score is high " do
      expect(ab_split_tester.confidence_score).to be > 0.95
    end
  end
end
