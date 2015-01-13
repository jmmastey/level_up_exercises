require 'spec_helper'

describe ABCohort do
  context "with invalid input" do
    describe "#new" do
      it "returns exception unless input is ABDataSummary object" do
        expect { ABCalculator.new("source_data.json") }.to raise_error
        expect { ABCalculator.new([47, 1302, 79, 1464]) }.to raise_error
      end
    end
  end

  context "with valid input" do
    let(:data_summary) { ABDataSummary.new("source_data.json") }
    let(:sample_calculator) { ABCalculator.new(data_summary) }

    describe "#new" do
    end
  end
end