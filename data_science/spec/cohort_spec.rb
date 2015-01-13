require 'spec_helper'

describe Cohort do
  context "with invalid input" do
    describe "#new" do
      it "returns exception if no trials" do
        expect { Cohort.new(0, 0) }.to raise_error(ArgumentError)
      end

      it "returns exception if inputs are not integers" do
        expect { Cohort.new(0.1, 13) }.to raise_error(TypeError)
        expect { Cohort.new(15, "fifteen") }.to raise_error(TypeError)
      end

      it "returns exception for negative data" do
        expect { Cohort.new(32, -2) }.to raise_error(ArgumentError)
        expect { Cohort.new(-1, 0) }.to raise_error(ArgumentError)
      end
    end
  end

  context "with valid input" do
    subject(:sample_cohort) { Cohort.new(10, 12) }

    describe "#new" do
      it "returns conversion stats" do
        expect(sample_cohort.conversions).to eq(10)
        expect(sample_cohort.nonconvs).to eq(12)
      end
    end

    describe "#total_trials" do
      it "returns sum of conversion data" do
        expect(sample_cohort.total_trials).to eq(22)
      end
    end

    describe "#conversion_rate" do
      it "calculates conversion rate" do
        expect(sample_cohort.conversion_rate).to eq(0.454545)
      end
    end

    describe "#standard_error" do
      it "calculates standard error" do
        expect(sample_cohort.standard_error).to be_within(0.001).of(0.106)
      end
    end

    describe "#conversion_range" do
      it "calculates conversion range" do
        expect(sample_cohort.conversion_range).not_to cover(0.246)
        expect(sample_cohort.conversion_range).to cover(0.247)
        expect(sample_cohort.conversion_range).to cover(0.662)
        expect(sample_cohort.conversion_range).not_to cover(0.663)
      end
    end
  end
end
