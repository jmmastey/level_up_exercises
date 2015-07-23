require_relative 'spec_helper'

describe JsonReader do

  let(:reader) { JsonReader.new }

  describe '#new' do
    context 'when initializing data reader' do
      it 'should not be nil' do
        expect(reader).to_not be_nil
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
