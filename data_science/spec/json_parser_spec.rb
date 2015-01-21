require "spec_helper"
require "json"
require "tempfile"

describe JsonParser do
  describe "#parse" do
    let(:file)              { Tempfile.open("json_data.json") }
    let(:invalid_file)      { Tempfile.open("invalid_json_data.json") }
    before do
      raw_data = [{ date: "2015-01-01", cohort: "B", result: 1 },
                  { date: "2015-01-01", cohort: "A", result: 0 },
                  { date: "2015-01-01", cohort: "B", result: 0 },
                  { date: "2015-01-01", cohort: "B", result: 1 },
                  { date: "2015-01-02", cohort: "B", result: 0 },
                  { date: "2015-01-02", cohort: "A", result: 1 },
                  { date: "2015-01-02", cohort: "B", result: 0 },
                  { date: "2015-01-02", cohort: "B", result: 1 }]
      file.write(raw_data.map { |o| Hash[o.each_pair.to_a] }.to_json)
      file.rewind

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
      data_json = described_class.parse(file)
      expect(data_json["B"]["total_visits"]).to eq(6)
      expect(data_json["B"]["conversions"]).to eq(3)
    end
  end
end
