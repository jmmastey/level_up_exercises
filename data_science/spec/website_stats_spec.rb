require './website_data'

describe WebsiteStats do
  let(:test_data) do
    [{ "date" => "2014-03-20", "cohort" => "B", "result" => 0 },
     { "date" => "2014-03-21", "cohort" => "B", "result" => 1 },
     { "date" => "2014-03-21", "cohort" => "A", "result" => 1 },
     { "date" => "2014-03-22", "cohort" => "A", "result" => 1 },
     { "date" => "2014-03-24", "cohort" => "A", "result" => 0 }]
  end
  let(:prep_data_answer) do
    { A: { not_converted: 1, converted: 2 },
      B: { not_converted: 1, converted: 1 } }
  end
  let(:stats) { WebsiteStats.new(test_data) }

  describe ".new" do
    it "Creates a new WebsiteData Object from a passed in array of hashes" do
      expect(stats.site_data).to be_a(WebsiteData)
    end
  end

  describe ".size_of_cohort" do
    it "returns the sample size of one cohort" do
      expect(stats.size_of_cohort("A")).to eq(3)
    end
  end

  describe ".num_of_conversions" do
    it "returns the number of conversions for one cohort" do
      expect(stats.num_of_conversions("A")).to eq(2)
    end
  end

  describe ".num_no_conversions" do
    it "returns the number of NON conversions for one cohort" do
      expect(stats.num_no_conversions("A")).to eq(1)
    end
  end

  describe ".cohort_values" do
    it "should return a hash the of the conversions and non convesions" do
      expect(stats.cohort_values("A")).to eq(not_converted: 1, converted: 2)
      expect(stats.cohort_values("B")).to eq(not_converted: 1, converted: 1)
    end
  end

  describe ".prep_data" do
    it "should build a data hash that can be passed to abanalyzer gem" do
      expect(stats.prep_data).to eq(prep_data_answer)
    end
  end
end
