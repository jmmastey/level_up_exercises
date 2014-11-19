require 'spec_helper'

require_relative 'ab_data_parser'

describe ABDataParser do
  let(:json) { '{ key" : "test" }' }
  context 'when calling read with' do
    it 'not enough parameters' do
      expect { ABDataParser.read }.to raise_error(ArgumentError)
    end

    it 'non json object' do
      expect { ABDataParser.read(json, 't', 't') }.to raise_error(RuntimeError)
    end
  end
  context 'when method return' do
    let(:data) do
      json_obj = '[ { "name" : "A", "result" : 1 },
                   { "name" : "A", "result" : 1 },
                   { "name" : "B", "result" : 1 },
                   { "name" : "B", "result" : 1 } ]'
      ABDataParser.read(json_obj, 'name', 'result')
    end

    it 'has 2 elements A and B' do
      expect(data.keys).to include(:A, :B)
    end

    it 'has total sample of 2 for A' do
      expect(data[:A][:total_samples]).to eq(2)
    end

    it 'has conversions of 2 for A' do
      expect(data[:A][:conversions]).to eq(2)
    end
  end
end
