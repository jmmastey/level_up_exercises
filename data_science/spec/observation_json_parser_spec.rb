require 'spec_helper'
require 'rspec/collection_matchers'
require_relative '../observation_json_parser'

describe ObservationJSONParser do
  let(:parser) { ObservationJSONParser.new("test_data/test_file.json") }
  let(:confidence) { Confidence.new }
  let(:interval_a) { confidence.interval("A") }
  let(:interval_b) { confidence.interval("B") }

  it 'should apply to confidence correctly' do
    parser.apply(confidence)
    expect(confidence.subjects).to match_array(["A", "B"])
    expect(interval_a.midpt).to be_within(an_angstrom).of(0.0)
    expect(interval_a.upper).to be_within(an_angstrom).of(0.0)
    expect(interval_b.midpt).to be_within(an_angstrom).of(0.5)
    expect(interval_b.upper).to be_within(an_angstrom).of(1.0)
  end
end
