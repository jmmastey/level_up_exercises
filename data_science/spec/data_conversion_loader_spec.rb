require_relative 'test_helper'

describe DataConversionLoader do
  let(:data) { conversion_data }
  let(:data_a) { conversion_data_a }

  it "should parse a JSON file" do
    expect(data).to be_an(Array)
  end

  it "should be able to parse the correct fields" do
    DATA_FIELDS.each { |field| expect(data[0]).to have_key(field) }
  end

  it "should have the same number of array elements as JSON elements" do
    elements = JSON.parse(File.read("source_data.json")).length
    expect(data.length).to eq(elements)
  end

  it "should understand how to filter by sample" do
    expect(data_a).to be_an(Array)
  end

  it "should keep the same fields after filter" do
    DATA_FIELDS.each { |field| expect(data_a[0]).to have_key(field) }
  end
end