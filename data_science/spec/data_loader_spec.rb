require 'data_loader'

RSpec.describe DataLoader do
  subject(:data_source) { DataLoader.new('data/test_data.json') }

  it 'will load a JSON file' do
    expect(subject.json?).to be_truthy
  end

  it 'will load data from the provided data source' do
    expect { subject.load_data }.not_to raise_error
    expect(subject.load_data).not_to be_empty
  end
end
