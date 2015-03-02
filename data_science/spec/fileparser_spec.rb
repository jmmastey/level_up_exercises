load 'fileparser.rb'
require 'spec_helper'
require 'rspec'

describe FileParser do
  context 'raise an error when' do
    it 'Not a json file' do
      expect { FileParser.parse_data('test') }.to raise_error(RuntimeError)
    end
    it 'Not a correct file' do
      expect { FileParser.parse_data('test.json') }.to raise_error(RuntimeError)
    end
    it 'Not a valid arguments' do
      expect { FileParser.parse_data }.to raise_error(ArgumentError)
    end
  end
end
