require './spec/spec_helper.rb'

describe Model::Sample do
  describe "#self.inherited" do
    it "should inherit Datum class" do
      expect(Model::Sample).to be < Model::Datum
    end
  end
  describe "#CONVERION_RATE_MULTIPLIER" do
    it "has a rate of 1.96" do
      expect(Model::Sample::CONVERSION_RATE_MULTIPLIER).to eq(1.96)
    end
  end
  describe "#size" do
    it "returns the size of the sample"
  end
  describe "#cohort_size" do
    it "returns the size of a given cohort"
  end
  describe "#conversions" do
    it "calculates the conversions for a cohort"
  end
  describe "#non_conversions" do
    it "calculates the non conversions for a cohort"
  end
end
