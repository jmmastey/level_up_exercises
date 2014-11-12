require_relative "spec_helper"
require_relative "../load_json"

describe LoadJSON do
  subject(:source_data) { LoadJSON.new("test_data.json") }

  it "should exists on filesystem" do
    expect(File.exist?(source_data.file_path)).to be_truthy
  end

  it "should be valid JSON filename" do
    expect(source_data.file_path).to end_with(".json")
  end

  it "should not be empty" do
    expect(source_data.parse).not_to be_empty
  end

  it "should have 48 lines" do
    expect(source_data.parse.length).to be(48)
  end
end
