require 'spec_helper'

describe SplitTestData do 
  before :each do 
    file = 'spec/test_data.json'
    file_contents = File.open(file, 'r') {|f| f.read }
    @data = SplitTestData.new(file_contents)
  end

  describe "#new" do
    it "takes a json object and returns a SplitTestData object" do
      expect(@data).instance_of? SplitTestData
    end
  end
end