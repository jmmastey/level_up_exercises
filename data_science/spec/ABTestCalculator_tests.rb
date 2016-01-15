require_relative '../lib/ABTestCalculator'

RSpec.describe ABTestCalculator, "#read_data" do
  before do
    @abtc = ABTestCalculator.new(
      json_file: 'data_export_2014_06_20_15_59_02.json',
    )
  end

  context "On initialization of class" do
    it "reads data from a JSON file and stores in an array" do
      expect(@abtc.data.is_a?(Array)).to eq true
    end
  end

  context "for a given experiment" do
    it "returns total sample size as an integer" do
      expect(@abtc.total_sample_size.is_a?(Integer)).to eq true
    end

    it "returns total number of conversions as an integer" do
      expect(@abtc.total_conversions.is_a?(Integer)).to eq true
    end
  end
end
