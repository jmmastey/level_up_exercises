require_relative '../a_b_split_tester.rb'
require_relative '../data_loader.rb'

RSpec.describe ABSplitTester do
  before(:context) do
    @data = DataLoader.new('ab_test_data.json')
    @ab_split_obj = ABSplitTester.new(@data.value)
  end

  describe "Total Size" do
    it "returns 44 for our test data" do
      expect(@data.total_size).to eq(44)
    end
  end

  describe "Cohorts Count" do
    it "returns 2 cohorts count for data" do
      expect(@ab_split_obj.cohorts_count).to eq(2)
    end
  end

  describe "Count conversion rate for cohort" do
    it "given a cohort, returns the count of rows where result is 1" do
      expect(@ab_split_obj.conversion_count("A")).to eq(9)
      expect(@ab_split_obj.conversion_count("B")).to eq(17)
    end
  end

  describe "Get conversion rate for cohort" do
    it "returns the count of rows where result is 1" do
      expect(@ab_split_obj.conversion_rate("A")).to eq([0.21691521438944278, 0.6402276427534144])
      expect(@ab_split_obj.conversion_rate("B")).to eq([0.5596750807463663, 0.918585788818851])
    end
  end

  describe "Accept or reject Null Hypothesis that Current leader is better" do
    it "checks chi_square_p score is less than " do
      expect(@ab_split_obj.confidence_score).to eq(0.9636301386563062)
    end
  end
end
