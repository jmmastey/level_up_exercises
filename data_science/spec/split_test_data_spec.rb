require 'spec_helper'

describe SplitTestData do 
  before :each do 
    @data = SplitTestData.new('spec/test_data.json')
  end

  describe "#new" do
    it "takes a json object and returns a SplitTestData object" do
      expect(@data).instance_of? SplitTestData
    end
  end

  describe "#count" do
    it "counts how many rows have a specific value in a specific field." do
      expect(@data.count("cohort", "A")).to eq(60)
    end
  end

  describe "#summary" do 
    it "sums the number of hits for each group" do
      pp @data.summary
      expect(@data.summary).to eq({'A' => 36, 'B' => 30})
    end
  end
end