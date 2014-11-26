require 'spec_helper'
require '../dataparser'

describe DataParser do
  let(:parser) { DataParser.new }
  context 'will raise error when' do
    it 'unkown file is passed' do
      expect { parser.load_json_file('nofile.json') }.to raise_error(Errno::ENOENT)
    end
    it 'incorrect json file is passed' do
      expect { parser.load_json_file('incorrect.json') }.to raise_error(JSON::ParserError)
    end
  end
  context 'when load_json_file is called' do
    let(:value) { parser.load_json_file('test.json') }
    it 'will return summary of data' do
      expect(value).to eq('A' => { total: 1, conversion: 0 },
                          'B' => { total: 5, conversion: 1 })
    end
  end
end
