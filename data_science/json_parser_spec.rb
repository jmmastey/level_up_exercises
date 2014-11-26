require 'rspec'
require 'spec_helper'
require_relative 'json_parser.rb'

describe JsonParser do
  let(:json_parser) { JsonParser.new }

  context 'raise an error when it' do
    it 'is not json file ' do
      expect { JsonParser.read(json, 't', 't') }.to raise_error(RuntimeError)
    end
    it 'is not correct file name ' do
      expect { JsonParser.read('abc.json') }.to raise_error(RuntimeError)
    end
    it 'has not enough parameters' do
      expect { JsonParser.read }.to raise_error(ArgumentError)
    end
  end
end
