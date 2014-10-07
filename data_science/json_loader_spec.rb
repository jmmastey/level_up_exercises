require_relative 'json_loader'

describe JSONLoader do
  loader = JSONLoader.new('test_data.json')

  it "should be a JSONLoader object" do
    expect(loader).to be_kind_of(JSONLoader)
  end

  it "should be a JSONLoader instance" do
    expect(loader).to be_instance_of(JSONLoader)
  end

  it "should have a legit data source" do
    expect(loader.file_name).to eq('test_data.json')
    expect(loader.file_name).not_to eq('sample.csv')
  end

  it "should be able to load data" do
    expect(loader).to respond_to(:fetch_data)
  end

  it "should load data from a data source" do
    data = loader.fetch_data

    expect(data).not_to be_empty
  end
end
