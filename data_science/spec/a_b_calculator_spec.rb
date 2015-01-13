require 'spec_helper'

describe ABCalculator do
  context "with invalid input" do
    describe "#new" do
      it "returns exception if any parameter is not an integer" do
        expect { ABCalculator.new(12.2, 10, 20, 30) }.to raise_error
      end

      it "returns exception if any parameter is negative" do
        expect { ABCalculator.new(10, -20, 30, 40) }.to raise_error
      end

      it "returns exception if either cohort has no total trials" do
        expect { ABCalculator.new(0, 0, 10, 20) }.to raise_error
        expect { ABCalculator.new(20, 30, 0, 0) }.to raise_error
      end
    end
  end

  context "with valid input" do
    let(:sample_calculator) { ABCalculator.new(30, 70, 43, 57) }
    describe "#confidence_level" do
      it "returns confidence_level" do
        expect(sample_calculator.confidence_level).to eq(0.943788)
      end
    end
  end
end
