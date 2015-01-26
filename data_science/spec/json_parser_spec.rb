require "spec_helper"
require "json"
require "tempfile"

describe JsonParser do
  let(:file)              { File.open("test_data.json") }
  let(:invalid_file)      { Tempfile.open("invalid_json_data.json") }
  let(:data_json)         { described_class.parse(file) }
  describe "#parse" do
    before do
      invalid_file.write("wrong format")
      invalid_file.rewind
    end

    it "errors when invalid file is passed" do
      expect { JsonParser.parse("bogus file") }.to raise_error ArgumentError
    end

    it "errors when json is invalid" do
      expect { JsonParser.parse(invalid_file) }.to raise_error JSON::ParserError
    end

    it "parses json and stores results in to hash with date as keys" do
      expect(data_json["B"]["total_visits"]).to eq(10)
      expect(data_json["B"]["conversions"]).to eq(6)
    end
  end
end
