require 'spec_helper'
require 'cohort'

describe Cohort do
  describe "#conversion_rate_interval" do
    let(:cohort) { Cohort.new("A", 20, 10) }
    it "gets the right range" do
      expect(cohort.conversion_rate_min).to be_within(0.01).of(0.28)
      expect(cohort.conversion_rate_max).to be_within(0.01).of(0.72)
    end
  end

  describe "#is_better_than?" do
    context "when A is better than B" do
      let(:cohort_b) { Cohort.new("B", 20, 10) }
      context "when the difference is significant" do
        let(:cohort_a) { Cohort.new("A", 20, 18) }
        it "is true" do
          expect(cohort_a).to be_better_than(cohort_b)
        end
      end

      context "when the difference is not significant" do
        let(:cohort_a) { Cohort.new("A", 20, 15) }
        it "is true" do
          expect(cohort_a).to be_better_than(cohort_b)
        end
      end
    end

    context "when A is NOT better than B" do
      let(:cohort_a) { Cohort.new("A", 20, 10) }
      let(:cohort_b) { Cohort.new("B", 20, 10) }
      it "is false" do
        expect(cohort_a).not_to be_better_than(cohort_b)
      end
    end
  end

  describe "#significance_of_difference" do
    context "when A is better than B" do
      let(:cohort_b) { Cohort.new("B", 20, 10) }
      context "when the difference is significant" do
        let(:cohort_a) { Cohort.new("A", 20, 18) }
        it "returns the right percentage" do
          significance = cohort_a.significance_of_difference(cohort_b)
          expect(significance).to be_within(0.1).of(99.5)
        end
      end

      context "when the difference is not significant" do
        let(:cohort_a) { Cohort.new("A", 20, 15) }
        it "returns the right percentage" do
          significance = cohort_a.significance_of_difference(cohort_b)
          expect(significance).to be_within(0.1).of(89.8)
        end
      end
    end
  end

  describe "#to_s" do
    let(:cohort_a) { Cohort.new("A", 20, 18) }
    it "correctly converts itself to a string" do
      description = cohort_a.to_s
      expect(description).to include("Cohort A")
      expect(description).to include("20 samples")
      expect(description).to include("18 conversions")
      expect(description).to include("conversion rate")
      expect(description).to include("95% confidence")
    end
  end
end
