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
end
