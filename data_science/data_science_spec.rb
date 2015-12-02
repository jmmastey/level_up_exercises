require './data_science'
require './json_io'

RSpec.describe DataScience do
  describe "#significance?" do
    it "should calculate a small sample and return false" do
      data = JsonIO.new("./test_data.json").read
      data_science = DataScience.new(data)
      expect(data_science.significance?).to eq(false)
    end
  end

  describe "#count" do
    it "should return the count based on given criteria" do
      data = JsonIO.new("./test_data.json").read
      data_science = DataScience.new(data)
      hash = { "cohort" => "B", "result" => 1 }
      expect(data_science.count(hash)).to eq(14)
    end
    it "should return the count based on given criteria" do
      data = JsonIO.new("./test_data.json").read
      data_science = DataScience.new(data)
      hash = { "cohort" => "A", "result" => 1 }
      expect(data_science.count(hash)).to eq(7)
    end
    it "should return the count based on given criteria" do
      data = JsonIO.new("./test_data.json").read
      data_science = DataScience.new(data)
      hash = { "cohort" => "B" }
      expect(data_science.count(hash)).to eq(35)
    end
    it "should return the count based on given criteria" do
      data = JsonIO.new("./test_data.json").read
      data_science = DataScience.new(data)
      hash = { "cohort" => "A", "result" => 99 }
      expect(data_science.count(hash)).to eq(0)
    end
  end

  describe "#sample_size" do
    it "should return a hash of total group counts" do
      data = JsonIO.new("./test_data.json").read
      data_science = DataScience.new(data)
      expected = { "Total" => 70, "A" => 35, "B" => 35 }
      expect(data_science.sample_size).to be == expected
    end
  end

  describe "#conversions" do
    it "should return a hash of conversions for each cohort" do
      data = JsonIO.new("./test_data.json").read
      data_science = DataScience.new(data)
      expected = { "A" => 7, "B" => 14 }
      expect(data_science.conversions).to be == expected
    end
  end

  describe "#confidence" do
    it "should return a 95% confidence range for success rates" do
      data = JsonIO.new("./test_data.json").read
      data_science = DataScience.new(data)
      expected = { "A" => [0.067, 0.333],
                   "B" => [0.238, 0.562] }
      actual = data_science.confidence
      actual.each { |_, v| v.map! { |f| f.round(3) } }
      expect(actual).to be == expected
    end
  end
end
