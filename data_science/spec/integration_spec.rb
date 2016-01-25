require './data_science'

describe "Testing the integration with the abanalyzer gem" do
  context "When the data set for two cohorts are the same" do
    it "The abanalyzer gem should return false" do
      test_array = []
      20.times do
        test_array << { "date" => "2014-03-20", "cohort" => "B", "result" => 0 }
        test_array << { "date" => "2014-03-20", "cohort" => "A", "result" => 0 }
      end
      5.times do
        test_array << { "date" => "2014-03-20", "cohort" => "B", "result" => 1 }
        test_array << { "date" => "2014-03-20", "cohort" => "A", "result" => 1 }
      end
      expect(DataScience.new(test_array).analyze).to eql(false)
    end
  end

  context "When the data set for two cohorts are very different" do
    it "The abanalyzer gem should return true" do
      test_array = []
      20.times do
        test_array << { "date" => "2014-03-20", "cohort" => "B", "result" => 1 }
        test_array << { "date" => "2014-03-20", "cohort" => "A", "result" => 0 }
      end
      5.times do
        test_array << { "date" => "2014-03-20", "cohort" => "B", "result" => 0 }
        test_array << { "date" => "2014-03-20", "cohort" => "A", "result" => 1 }
      end
      expect(DataScience.new(test_array).analyze).to eql(true)
    end
  end
end
