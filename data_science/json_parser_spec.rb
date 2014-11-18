require_relative "json_parser"

describe JSONParser do
  subject(:file_loader) { JSONParser.new("test_data.json") }

  it "works with a real data source" do
    expect(subject.filename).to end_with(".json")
  end

  it "loads data correctly from a data source" do
    expect(subject.fetch_data.length).to eq(10)
  end

  context "detects wrong file extentions" do
    subject(:faulty_file) { JSONParser.new("faulty_file.voorhees") }
    it "raises exception when wrong file type is passed" do
      raise_error(FileTypeException, "Not a JSON, buddy")
    end
  end

end
