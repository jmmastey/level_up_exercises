# Some questions I have for code review
# how to "DRY" out code, for example repeating all the stuff in mocks..."

require "spec_helper"
require_relative "../results"

describe Results do
  let(:results) { Results.new }

  describe "#initialize" do
    it "should start with no data" do
      expect(results.data_points.count).to eq(0)
    end
  end

  describe "#add_data" do
    it "should be called with a file" do
      results.add_data("source_data.json")
      expect(results.filename).to eq("source_data.json")
    end

    it "raises an error if no filename" do
      expect { results.add_data }.to raise_error
    end
  end

  context "after data has been added" do
    let(:results) do
      mock_json = %([{"date":"2014-03-20","cohort":"B","result":1},)
      mock_json += %({"date":"2014-03-20","cohort":"A","result":1},)
      mock_json += %({"date":"2014-03-20","cohort":"A","result":0}])

      allow(File).to receive(:read).with("some_file").and_return(mock_json)

      results = Results.new
      results.add_data("some_file")
      results
    end

    it "parses JSON data and stores as cohort objects" do
      expect(results.data_points.first).to be_a DataPoint
      expect(results.data_points.last).to be_a DataPoint
    end

    it "should create data object for each element in json input" do
      expect(results.data_points.count).to eq(3)
    end

    it "should add a key for each cohort" do
      expect(results.cohorts.has_key? "A").to eq(true)
    end

    describe "#cohorts" do
      it "should have an accurate count of cohort data" do
        expect(results.cohorts["A"].visitors).to eq(2)
        expect(results.cohorts["A"].conversions).to eq(1)

        expect(results.cohorts["B"].visitors).to eq(1)
        expect(results.cohorts["B"].conversions).to eq(1)
      end
    end
  end
end
