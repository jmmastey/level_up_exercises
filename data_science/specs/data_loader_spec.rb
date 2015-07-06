require 'rspec'
require_relative 'constants'
require_relative '../lib/json_reader'



describe 'JSON Reader' do
  describe 'Initialization' do
    before :each do
      @reader = JsonReader.new
    end
    context 'when initializing data reader' do
      it 'should not be nil' do
        expect(@reader).to_not be_nil
      end
    end
  end

  describe '.load_data' do
    context 'when loading data' do
      it 'should load all elements' do
        expect(JsonReader.new.load_data(JSON_FILE_PATH).count).to eq(2892)

      end
    end
  end
end