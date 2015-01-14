require 'spec_helper'

describe ABCalculator do
  context "with invalid input" do
    describe "#new" do
      it "returns exception if any parameter is not an integer" do
        expect { ABCalculator.new(10.0, 20, 30, 40) }.to raise_error(TypeError)
        expect { ABCalculator.new(10, "twenty", 30, 40) }.to \
          raise_error(TypeError)
        expect { ABCalculator.new(10, 20, :thirty, 30) }.to \
          raise_error(TypeError)
        expect { ABCalculator.new(10, 20, 20, [40]) }.to raise_error(TypeError)
      end

      it "returns exception if any parameter is negative" do
        expect { ABCalculator.new(-10, 20, 30, 40) }.to \
          raise_error(ArgumentError)
        expect { ABCalculator.new(10, -20, 30, 40) }.to \
          raise_error(ArgumentError)
        expect { ABCalculator.new(10, 20, -30, 40) }.to \
          raise_error(ArgumentError)
        expect { ABCalculator.new(10, 20, 30, -40) }.to \
          raise_error(ArgumentError)
      end

      it "returns exception if either cohort has no total trials" do
        expect { ABCalculator.new(0, 0, 10, 20) }.to raise_error(ArgumentError)
        expect { ABCalculator.new(20, 30, 0, 0) }.to raise_error(ArgumentError)
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

    describe "#different?" do
      it "returns whether the cohorts are different" do
        expect(sample_calculator.different?).to be false
      end
    end
  end
end
