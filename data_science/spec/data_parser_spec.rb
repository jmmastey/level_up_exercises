require "spec_helper"
require_relative "../data_parser"

describe DataParser do
  describe "#initialize" do
    xit "raises an error if no filename" do
      expect { DataParser.new }.to raise_error
    end

    xit "should be initialized with a file" do
      parser = DataParser.new("source_data.json")
      parser.filename.should eq("source_data.json")
    end

    xit "parses JSON data and stores as data objects" do
      mock_json = "[{\"date\":\"2014-03-20\",\"cohort\":\"B\",\"result\":1},"
      mock_json += "{\"date\":\"2014-03-20\",\"cohort\":\"A\",\"result\":0}]"
      allow(File).to receive(:read).with("some_file").and_return(mock_json)

      parser = DataParser.new("some_file")
      expect(parser.data).to include(Data.new(cohort: "A", result: 0))
      expect(parser.data).to include(Data.new(cohort: "B", result: 1))
      # pass mock/stub
      # inject json data (inject a magic mock)
    end

    xit "should create data object for each element in json input" do
      mock_json = "[{\"date\":\"2014-03-20\",\"cohort\":\"B\",\"result\":1},"
      mock_json += "{\"date\":\"2014-03-20\",\"cohort\":\"A\",\"result\":0}]"
      allow(File).to receive(:read).with("some_file").and_return(mock_json)

      parser = DataParser.new("some_file")

      expect(parser.data.count).to be(2)
#      expect(parser).to have(2).data
    end
  end
end
