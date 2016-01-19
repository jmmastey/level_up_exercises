$LOAD_PATH << "."

require "DataLoader"

RSpec.describe DataLoader, "#read_data" do
  before do
    @data = DataLoader.load_data('data_export_2014_06_20_15_59_02.json')
  end
  context "On load data" do
    it "reads data from a JSON file and stores in an array" do
      expect(@data.is_a?(Hash)).to eq true
    end

    it "also parses the data" do
      expect(@data["2014-03-20"]["B"]).to eq 5
    end
  end
end
