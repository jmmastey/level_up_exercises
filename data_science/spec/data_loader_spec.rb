require 'data_loader'

RSpec.describe DataLoader do
  it 'will load a JSON file' do
    expect(DataLoader.new('test_data.json').data_source).to end_with('.json')
  end
end
