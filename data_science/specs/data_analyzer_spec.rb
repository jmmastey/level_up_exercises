require_relative "../data_analyzer"
require_relative "../errors"

describe DataAnalyzer do
  it "should fail if the specified file does not exist" do
    expect { DataAnalyzer.new("some-file.json") }.to raise_error(MissingFileError)
  end

  describe "should load an array of hashes" do
    let(:filepath) { Dir.getwd.concat("/specs/sample-small-test.json") }
    let(:analyzer) { DataAnalyzer.new(filepath) }

    context "#parse_data" do
      let(:cohort_data) { analyzer.parse_data }
      it "creates a hash of values associated with an identical key from a JSON file" do
        expect(cohort_data).to be_a(Hash)
        expect(cohort_data.values).to be_an(Array)
      end
    end
  end
end
