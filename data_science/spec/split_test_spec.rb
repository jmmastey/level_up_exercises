require 'spec_helper'

describe SplitTest do 
  before :each do 
    @data = SplitTestData.new('spec/test_data.json')
    @test = SplitTest.new(@data)
  end

  describe "#new" do
    it "takes a SplitTestData object and returns a SplitTest object" do
      expect(@test).instance_of? SplitTest
    end
  end

  describe "#confidence" do 
    it "finds min/max predictions for a given confidence level" do
      expect(@test.confidence).to eq(
        {
          "A"=>[0.968846875179678, 0.9978197914869885], 
          "B"=>[0.2897785784092367, 0.3768880882574299]
        })
    end
  end

  describe "#chi_square" do 
    it "returns the p values for a chi_square test" do 
      expect(@test.chi_square).to eq(0) 
    end
  end
end