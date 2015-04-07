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
end