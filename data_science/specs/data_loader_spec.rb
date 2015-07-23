require_relative 'spec_helper'

describe JsonReader do
  let(:reader) { JsonReader.new }

  describe '#new' do
    context 'when initializing data reader' do
      it 'does not raise error' do
        expect { reader }.not_to raise_error
      end
    end
  end

  describe '#load_data' do
    context 'when loading data' do
      it 'should load all elements' do
        expect(reader.load_data(JSON_FILE_PATH).count).to eq(2892)
      end
    end
  end
end
