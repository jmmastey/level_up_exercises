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

  describe "#attempts" do
    it "counts number of attempts per cohort." do
      expect(@data.attempts).to eq({'A' => 300, 'B' => 450})
    end
  end

  describe "#successes" do 
    it "sums the number of hits for each group" do
      expect(@data.successes).to eq({'A' => 295, 'B' => 150})
    end
  end
end