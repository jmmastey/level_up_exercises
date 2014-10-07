require_relative 'json_loader'
require_relative 'dataset'

describe Dataset do
  json = JSONLoader.new('test_data.json').fetch_data
  dataset = Dataset.new(json)

  it "should be a Dataset object" do
    expect(dataset).to be_kind_of(Dataset)
  end

  it "should be a Dataset instance" do
    expect(dataset).to be_instance_of(Dataset)
  end

  it "should initialize with data" do
    expect(dataset.results.length).to eq(4)
  end

  it "should tell us the total sample size" do
    expect(dataset).to respond_to(:total_sample_size)
    expect(dataset.total_sample_size).to eq(4)
  end

  it "should tell us the number of conversions" do
    expect(dataset).to respond_to(:number_of_conversions).with(1).argument
    expect(dataset.number_of_conversions('A')).to eq(1)
  end
end
