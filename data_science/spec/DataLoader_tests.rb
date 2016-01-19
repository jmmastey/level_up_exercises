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

    it "has cohort A conversion data" do
      expect(@data[:A][:results][:conversion]).to eq 47
    end

    it "has cohort B conversion data" do
      expect(@data[:B][:results][:conversion]).to eq 79
    end

    it "has cohort A non-conversion data" do
      expect(@data[:A][:results][:nonconversion]).to eq 1302
    end

    it "has cohort B non-conversion data" do
      expect(@data[:B][:results][:nonconversion]).to eq 1464
    end

    it "has a cohort A sample size total" do
      expect(@data[:A][:total]).to eq 1349
    end

    it "has a cohort B sample size total" do
      expect(@data[:B][:total]).to eq 1543
    end
  end
end
