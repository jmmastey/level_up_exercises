require 'spec_helper'

describe ABCohort do
  context "with invalid input" do
    describe "#new" do
      it "returns exception for when cohort is not A or B" do
        expect { ABCohort.new("C", 1, 2) }.to raise_error
      end
      it "returns exception if no trials" do
        expect { ABCohort.new("A", 0, 0) }.to raise_error
      end
      it "returns exception for negative data" do
        expect { ABCohort.new("B", 32, -2) }.to raise_error
        expect { ABCohort.new("B", -1, 0) }.to raise_error
      end
    end
  end

  context "with valid input" do
    subject(:sample_cohort) { ABCohort.new("B", 10, 12) }

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
      it "returns sum of conversion data" do
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

    describe "#to_h" do
      it "returns conversion data as a hash" do
        expect(sample_cohort.to_h).to match(conversions: 10, nonconvs: 12)
      end
    end
  end
end
