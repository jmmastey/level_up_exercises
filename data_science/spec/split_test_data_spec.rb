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
end