require 'spec_helper'
require_relative '../confidence_report'

describe 'ConfidenceReport' do
  let(:confidence) do
    confidence = Confidence.new
    4.times { confidence.add(Observation.new('A', true )) }
    4.times { confidence.add(Observation.new('A', false)) }
    9.times { confidence.add(Observation.new('B', true )) }
    7.times { confidence.add(Observation.new('B', false)) }
    confidence
  end

  let(:report) { ConfidenceReport.new(confidence) }
  let(:expected_text_file) { 'fixtures/expected_confidence_report.txt' }
  let(:expected_text) { File.open(expected_text_file).read }

  it 'should display a pretty report with correct values' do
    expect(report.to_s).to eq(expected_text)
  end
end
