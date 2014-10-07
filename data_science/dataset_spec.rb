require_relative 'json_loader'
require_relative 'dataset'

describe Dataset do
  json = JSONLoader.new('source_data.json').fetch_data
  dataset = Dataset.new(json)

  it "should be a Dataset object" do
    expect(dataset).to be_kind_of(Dataset)
  end

  it "should be a Dataset instance" do
    expect(dataset).to be_instance_of(Dataset)
  end

  it "should initialize with data" do
    expect(dataset.results.length).to eq(2892)
  end

  it "should tell us the total sample size" do
    expect(dataset).to respond_to(:total_sample_size)
    expect(dataset.total_sample_size).to eq(2892)
  end

  it "should tell us the total users in group" do
    expect(dataset).to respond_to(:total_in_group).with(1).argument
    expect(dataset.total_in_group('A')).to eq(1349)
    expect(dataset.total_in_group('B')).to eq(1543)
  end

  it "should tell us the number of conversion" do
    expect(dataset).to respond_to(:number_of_conversions).with(1).argument
    expect(dataset.number_of_conversions('A')).to eq(47)
    expect(dataset.number_of_conversions('B')).to eq(79)
  end

  it "should tell us the percentage of conversion" do
    expect(dataset).to respond_to(:percentage_of_conversion).with(1).argument
    expect(dataset.percentage_of_conversion('A')).to eq(0.0348)
    expect(dataset.percentage_of_conversion('B')).to eq(0.0512)
  end

  it "should tell us the standard error" do
    expect(dataset).to respond_to(:calculate_standard_error).with(1).argument
    expect(dataset.calculate_standard_error('A')).to eq(0.0098)
    expect(dataset.calculate_standard_error('B')).to eq(0.0110)
  end
end
