require_relative "spec/spec_helper"
require_relative "load_json"

describe LoadJSON do
  let(:source_data) { LoadJSON.new("source_data.json") }

  it "can locate source file" do
    expect(source_data.exist?).to be(true)
  end

  it "loads from valid JSON filename" do
    expect(source_data.file_name).to end_with(".json")
  end

  it "loads data from a data source" do
    expect(source_data.parse).not_to be_empty
  end
end
