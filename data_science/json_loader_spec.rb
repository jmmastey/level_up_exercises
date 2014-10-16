require_relative "json_loader"

describe JSONLoader do
  subject(:file_loader) { JSONLoader.new("test_no_winner_data.json") }

  it "works with a real data source" do
    expect(subject.file_name).to end_with(".json")
  end

  it "loads data from a data source" do
    expect(subject.fetch_data).not_to be_empty
  end
end
