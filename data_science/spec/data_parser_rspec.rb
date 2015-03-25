require_relative "spec_helper.rb"
describe DataParser do
  TEST_FILE = 'test_data_b.json'
  TEST_FILE_INSUFFICIENT_DATA = 'test_data_insufficient.json'
  FILE_NO_EXIST = 'blah.json'

  it 'reads input file successfully 'do
    expect(DataParser.new(TEST_FILE)).to_not be_nil
  end

  it 'raises error if file does not exist' do
    expect { DataParser.new(FILE_NO_EXIST) }.to raise_error
  end

  it 'raises error if insufficient data' do
    expect { DataParser.new(TEST_FILE_INSUFFICIENT_DATA) }.to raise_error
  end
end
