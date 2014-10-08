require_relative 'json_loader'
require_relative 'dataset'

describe Dataset do
  json = JSONLoader.new('source_data.json')
  dataset = Dataset.new(json.fetch_data)

  it "tells us the total sample size" do
    expect(dataset.total_sample_size).to eq(2892)
  end

  it "tells us the total users in group" do
    expect(dataset.total_in_group('A')).to eq(1349)
    expect(dataset.total_in_group('B')).to eq(1543)
  end

  it "tells us the number of conversion" do
    expect(dataset.number_of_conversions('A')).to eq(47)
    expect(dataset.number_of_conversions('B')).to eq(79)
  end

  it "tells us the percentage of conversion" do
    expect(dataset.percentage_of_conversion('A').round(4)).to eq(0.0348)
    expect(dataset.percentage_of_conversion('B').round(4)).to eq(0.0512)
  end

  it "tells us the standard error" do
    expect(dataset.calculate_standard_error('A').round(4)).to eq(0.0098)
    expect(dataset.calculate_standard_error('B').round(4)).to eq(0.0110)
  end

  it "tells us the chi-square probability" do
    expect(dataset.calculate_probability.round(4)).to eq(0.0316)
  end
end
