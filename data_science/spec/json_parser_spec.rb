require "spec_helper"
require "json"
require "tempfile"

describe JsonParser do
  describe "#parse" do
    let(:file)              { Tempfile.open("json_data.json") }

    before do
      raw_data = [{date:"2014-03-20",cohort:"B",result:0},
                  {date:"2014-03-21",cohort:"A",result:0},
                  {date:"2014-03-20",cohort:"B",result:0},
                  {date:"2014-03-21",cohort:"B",result:1}]
      file.write(raw_data.to_json)
      file.rewind
    end

    it "errors when invalid file is passed" do
      expect { described_class.parse("bogus file") }.to raise_error ArgumentError
    end

    it "parses json and stores results in to hash with date as keys" do
      data_json = described_class.parse(file)
      expect(data_json["2014-03-21"]["B"]).to eq(1)
    end
  end
end