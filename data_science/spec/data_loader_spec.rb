require 'data_loader'

RSpec.describe DataLoader do
  it 'will load a JSON file' do
    expect(DataLoader.new('test_data.json').json?).to be_truthy
  end

  it 'will load data from the provided data source' do
    expect { DataLoader.new('data/test_data.json').load_data }.not_to raise_error
    expect(DataLoader.new('data/test_data.json').load_data).not_to be_empty
  end
end
