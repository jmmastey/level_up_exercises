require_relative "../file_parser"
require_relative "../errors"

describe FileParser do
  let(:cohort_data) { FileParser.parse_data("specs/sample-small-test.json") }

  it "should fail if the specified file does not exist" do
    expect { FileParser.parse_data("some-file.json") }.to raise_error(MissingFileError)
  end

  context "#parse_data" do
    it "should return a hash of A/B results from a JSON file" do
      expect(cohort_data).to eql("A"=>[1, 1, 0], "B"=>[1, 0, 0])
    end
  end
end
