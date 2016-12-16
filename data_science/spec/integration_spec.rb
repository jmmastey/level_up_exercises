require './data_science'

describe "Testing the integration with the abanalyzer gem" do
  context "When the data set for two cohorts are the same" do
    it "The abanalyzer gem should return false" do
      test_array =  visits(20, "B", 0)
      test_array += visits(20, "A", 0)
      test_array += visits(5, "B", 1)
      test_array += visits(5, "A", 1)
      expect(DataScience.new(test_array).analyze).to be_falsey
    end
  end

  context "When the data set for two cohorts are very different" do
    it "The abanalyzer gem should return true" do
      test_array =  visits(20, "B", 0)
      test_array += visits(20, "A", 1)
      test_array += visits(5, "B", 1)
      test_array += visits(5, "A", 0)
      expect(DataScience.new(test_array).analyze).to be_truthy
    end
  end
end
