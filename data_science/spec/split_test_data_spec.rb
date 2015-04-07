describe SplitTestData do 
  before :each do 
    @data = SplitTestData.new(json)
  end

  describe "#new" do
    it "takes a json object and returns a SplitTestData object" do
      @data.should be_an_instance_of SplitTestData
    end
  end
end