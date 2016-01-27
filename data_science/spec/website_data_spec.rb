require './website_data'
require './website_stats'

describe WebsiteData do
  describe ".new" do
    let(:test_data) do
      [{ "date" => "2014-03-20", "cohort" => "B", "result" => 0 },
       { "date" => "2014-03-21", "cohort" => "A", "result" => 1 }]
    end
    let(:website_data) { WebsiteData.new(test_data) }
    let(:first_visit) { website_data.visits.first }

    it "accepts an array of hashes as it's parameter" do
      expect { WebsiteData.new(test_data) } .not_to raise_error
    end

    it "populates @visits with a scruct class" do
      expect(first_visit).to be_a(Struct)
    end

    it "populates @visits with date" do
      expect(first_visit[:date]).to eql(test_data.first["date"])
    end

    it "populates @visits with cohort" do
      expect(first_visit[:cohort]).to eql(test_data.first["cohort"])
    end

    it "populates @visits with result" do
      expect(first_visit[:result]).to eql(test_data.first["result"])
    end

    it "populates @visits with more than one data set" do
      expect(website_data.visits.size).to eql(2)
    end
  end

  describe ".filtered_size" do
    let(:test_data) do
      [{ "date" => "2014-03-20", "cohort" => "B", "result" => 0 },
       { "date" => "2014-03-21", "cohort" => "B", "result" => 1 },
       { "date" => "2014-03-21", "cohort" => "A", "result" => 1 },
       { "date" => "2014-03-22", "cohort" => "A", "result" => 1 },
       { "date" => "2014-03-24", "cohort" => "A", "result" => 0 }]
    end
    let(:website_data) { WebsiteData.new(test_data) }

    it "accepts an array for the filtering parameters" do
      filter_params = { cohort: "B", result: 0 }
      expect { website_data.filtered_size(filter_params) }.not_to raise_error
    end

    it "returns the correct size for filtering by cohort only" do
      expect(website_data.filtered_size(cohort: "B")).to eql(2)
    end

    it "returns the correct size for filtering by result only" do
      expect(website_data.filtered_size(result: 1)).to eql(3)
    end

    it "returns the correct size for filtering by cohort and result" do
      expect(website_data.filtered_size(cohort: "B", result: 0)).to eql(1)
    end
  end
end
