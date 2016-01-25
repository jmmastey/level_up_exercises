require './website_data'
require './website_stats'
require './data_science'

describe DataScience do
  let(:test_data) do
    [{ "date" => "2014-03-20", "cohort" => "B", "result" => 0 },
     { "date" => "2014-03-21", "cohort" => "B", "result" => 1 },
     { "date" => "2014-03-21", "cohort" => "A", "result" => 1 },
     { "date" => "2014-03-22", "cohort" => "A", "result" => 1 },
     { "date" => "2014-03-24", "cohort" => "A", "result" => 0 }]
  end
  let(:test_data_science) { DataScience.new(test_data) }

  describe ".calc_conversion_ranges" do
    it "sends converted, total, and p value to ABAnalyzer" do
      expect(ABAnalyzer).to receive(:confidence_interval).with(2, 3, 0.95)
      test_data_science.calc_conversion_ranges("A")
    end
  end
end
