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
      expect(@test.confidence(1000, 4000, 0.95)) === [0.23658104401082297, 0.26341895598917703]
    end
  end

  describe "#sample_size" do
    it "finds the required sample size for accurate analysis" do 
      expect(@test.sample_size(0.1, 0.11, 0.05, 0.8))
    end
  end
end