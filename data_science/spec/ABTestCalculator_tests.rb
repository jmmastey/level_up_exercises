$LOAD_PATH << "../lib"

require 'ABTestCalculator'

RSpec.describe ABTestCalculator, "#read_data" do
  before do
    @abtc = ABTestCalculator.new(
      json_file: 'data_export_2014_06_20_15_59_02.json',
    )
  end

  context "On initialization of class" do
    it "reads data from a JSON file and stores in a hash" do
      expect(@abtc.data.is_a?(Hash)).to eq true
    end
  end

  context "for a given experiment" do
    it "returns confidence level" do
      expect(@abtc.confidence_level).to eq 0.031564025460594
    end
  end

  context "for each cohort" do
    it "returns a conversion rate" do
      expect(@abtc.cohort_conversion_rate).to eq(
        A: [0.025055087455844, 0.04462615791109446],
        B: [0.04020173369400816, 0.06219619242394388],
      )
    end
  end
end
