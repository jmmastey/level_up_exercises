# Some questions I have for code review
# how to "DRY" out code, for example repeating all the stuff in mocks..."

require "spec_helper"
require_relative "../results"

describe Results do
  describe "#initialize" do
    it "should start with no data" do
      results = Results.new
      expect(results.data.count).to eq(0)
    end
  end

  describe "#add_data" do
    it "should be called with a file" do
      results = Results.new
      results.add_data("source_data.json")
      results.filename.should eq("source_data.json")
    end

    it "raises an error if no filename" do
      results = Results.new
      expect { results.add_data }.to raise_error
    end

    it "parses JSON data and stores as cohort objects" do
      mock_json = "[{\"date\":\"2014-03-20\",\"cohort\":\"B\",\"result\":1},"
      mock_json += "{\"date\":\"2014-03-20\",\"cohort\":\"A\",\"result\":0}]"
      allow(File).to receive(:read).with("some_file").and_return(mock_json)

      results = Results.new
      results.add_data("some_file")

      expect(results.data.first).to be_a DataPoint
      expect(results.data.last).to be_a DataPoint
    end

    it "should create data object for each element in json input" do
      mock_json = "[{\"date\":\"2014-03-20\",\"cohort\":\"B\",\"result\":1},"
      mock_json += "{\"date\":\"2014-03-20\",\"cohort\":\"A\",\"result\":1},"
      mock_json += "{\"date\":\"2014-03-20\",\"cohort\":\"A\",\"result\":0}]"
      allow(File).to receive(:read).with("some_file").and_return(mock_json)

      results = Results.new
      results.add_data("some_file")

      expect(results.data.count).to eq(3)
    end
  end
end
