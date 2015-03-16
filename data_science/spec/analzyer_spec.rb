require_relative "spec_helper"

describe Analyzer do
  TEST_FILE = "data_simple_test.json"

  it "should initialize successfully" do
    expect { Analyzer.new(TEST_FILE) }.not_to raise_error
  end
  it "should calculate confidence level" do
    analyzer = Analyzer.new(TEST_FILE) 
    expect(analyzer.confidence_level).to be_within(0.01).of(96.08)
  end
end
