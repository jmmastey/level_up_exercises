require_relative 'spec_helper'

describe DataAnalyzer do
  let(:data_analyzer) { DataAnalyzer.new('test_data.json') }

  it "returns the correct confidence level" do
    expect(data_analyzer.confident?).to be false
  end
end
