require './parser'
require './ab_split_test'

describe ParsedData do
  let(:data) { ParsedData.new('test.json') }

  describe "Data size" do
    it "should have a count of 30 for test data" do
      expect(data.size).to eq(60)
    end
  end
end

describe ABSplitTest do
  let(:data) { ParsedData.new('test.json') }
  let(:ab_split) { ABSplitTest.new(data) }
  describe "Number of cohorts" do
    it "should have 2 cohorts" do
      expect(ab_split.cohorts.count).to eq(2)
    end
  end

  describe "Conversions for each cohort" do
    it "should have the correct number of conversions" do
      expect(ab_split.conversions["A"]).to eq(18)
      expect(ab_split.conversions["B"]).to eq(12)
    end
  end

  describe "Conversion rate for each cohort" do
    it "should produce the expected conversion rate" do
      expect(ab_split.conversion_rate("A")).to eq([0.2789078842430741, 0.578234972899783])
      expect(ab_split.conversion_rate("B")).to eq([0.4488928920461835, 0.8844404412871498])
    end
  end

  describe 'Accept or reject Null Hypothesis that Current leader is better' do
    it 'checks the chi_square_p score' do
      expect(ab_split.confidence_score).to eq(0.9090310520246423)
    end
  end
end
