require 'rspec'
require_relative 'spec_helper'
require_relative '../json_parser'

describe JsonParser do
  let(:json_parser) { JsonParser.new }

  context 'raise an error when it' do

    it 'is not json file ' do
      expect { json_parser.parse_data('abc.txt') }.to raise_error(RuntimeError)
    end

    it 'is not correct file name ' do
      expect { json_parser.parse_data('abc.json') }.to raise_error(RuntimeError)
    end

  end

  context 'when load_json_file is called' do
    let(:data) { json_parser.parse_data('test_data.json') }

    it 'will return data' do
      expect(data).to eq('B' => { total_samples: 28, conversions: 5 },
                         'A' => { total_samples: 19, conversions: 2 })
    end
  end

end
