require 'spec_helper'
require 'cohort'

describe Cohort do
  let(:cohort) { Cohort.new(name: "A", views: 20, conversions: 10) }
  let(:uneven_cohort) { Cohort.new(name: "A", views: 20, conversions: 8) }

  describe "#non_conversions" do
    it "is views minus conversions" do
      expect(uneven_cohort.non_conversions).to eq(12)
    end
  end

  describe "#conversion_rate_min" do
    it "is right" do
      expect(cohort.conversion_rate_min).to be_within(0.01).of(0.28)
    end
  end

  describe "#conversion_rate_max" do
    it "is right value" do
      expect(cohort.conversion_rate_max).to be_within(0.01).of(0.72)
    end
  end

  describe "#conversion_rate_midpoint" do
    it "it is right" do
      expect(cohort.conversion_rate_midpoint).to be_within(0.01).of(0.5)
    end
  end

  describe "#to_s" do
    let(:cohort_a) { Cohort.new(name: "A", views: 20, conversions: 18) }
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
