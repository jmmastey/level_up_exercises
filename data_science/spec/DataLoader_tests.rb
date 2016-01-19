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

    it "has cohort A data" do
      expect(@data[:A][:conversion]).to eq 47
    end

    it "has cohort B data" do
      expect(@data[:B][:conversion]).to eq 79
    end

    it "has a sample size total" do
      expect(@data[:sample_size]).to eq 2892
    end
  end
end
