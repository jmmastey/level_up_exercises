require_relative 'json_loader'

describe JSONLoader do
  loader = JSONLoader.new('source_data.json')
  loader.fetch_data

  it "has a legit data source" do
    expect(loader.file_name).to end_with('.json')
  end

  it "loads data from a data source" do
    expect(loader.data).not_to be_empty
  end
end
