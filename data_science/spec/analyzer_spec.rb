require 'spec_helper'

describe Analyzer do
  let(:filename) { "test_data.json" }
  let(:cohorts) { DataLoader.load_json(filename) }
  let(:analyzer) { Analyzer.new(cohorts) }

  describe "#initialize" do
    it "takes one argument and returns an Analyzer object" do
      expect(analyzer).to be_a(Analyzer)
      expect(analyzer.cohorts.size).to eq(2)
    end
  end

  describe "#initialize_abanalyzer" do
    it "takes zero arguments and initializes the ABAnalyzer" do
      expect(analyzer.abanalyzer).to be_a(ABAnalyzer::ABTest)
    end
  end

  describe "#better_than_random?" do
    it "takes zero arguments and returns true if the p-value is below 0.05" do
      expect(analyzer.better_than_random?).to eq(true)
    end
  end
end
