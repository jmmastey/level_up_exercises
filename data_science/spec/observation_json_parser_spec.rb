require 'spec_helper'
require 'rspec/collection_matchers'
require_relative '../observation_json_parser'

describe ObservationJSONParser do
  let(:parser) { ObservationJSONParser.new("test_data/test_file.json") }
  let(:observations) { parser.observations }

  it 'creates observations correctly' do
    expect(parser).to have(8).observations
  end
end
