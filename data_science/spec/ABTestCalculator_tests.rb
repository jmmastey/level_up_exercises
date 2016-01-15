require_relative '../lib/ABTestCalculator'

RSpec.describe ABTestCalculator, "#read_data" do
  context "On initialization of class" do
    it "reads data from a JSON file and stores in an array" do
      abtc = ABTestCalculator.new(
        json_file: 'data_export_2014_06_20_15_59_02.json',
      )
      expect(abtc.data.is_a?(Array)).to eq true
    end
  end
end
