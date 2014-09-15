require "spec_helper"
require_relative "../results"

describe Results do
  describe "#initialize" do
    it "should start with no cohort data" do
      results = Results.new
      expect(results.cohorts.count).to eq(0)
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

    xit "parses JSON data and stores as cohort objects" do
      mock_json = "[{\"date\":\"2014-03-20\",\"cohort\":\"B\",\"result\":1},"
      mock_json += "{\"date\":\"2014-03-20\",\"cohort\":\"A\",\"result\":0}]"
      allow(File).to receive(:read).with("some_file").and_return(mock_json)

      results = Results.new
      results.add_data("some_file")

      cohort_a = Cohort.new("A", conversions: 0, non_conversions: 1)
      cohort_b = Cohort.new("B", conversions: 1, non_conversions: 0)
      expect(results.cohorts).to include(cohort_a)
      expect(results.cohorts).to include(cohort_b)
    end

    xit "should create data object for each element in json input" do
    #  mock_json = "[{\"date\":\"2014-03-20\",\"cohort\":\"B\",\"result\":1},"
    #  mock_json += "{\"date\":\"2014-03-20\",\"cohort\":\"A\",\"result\":0}]"
    #  allow(File).to receive(:read).with("some_file").and_return(mock_json)

    #  parser = Results.new("some_file")

    #  expect(parser.data.count).to be(2)
#      expect(parser).to have(2).data
    end
  end
end
