require 'spec_helper'
require 'cohort'

describe Cohort do
  let(:cohort) { Cohort.new(name: "A", views: 20, conversions: 10) }
  let(:uneven_cohort) { Cohort.new(name: "A", views: 20, conversions: 8) }
  let(:nameless_cohort) { Cohort.new(name: nil, views: 0, conversions: 0) }

  # happy path tests
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
    context "when the cohort has a name" do
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

    # sad path tests
    context "when the cohort does not have a name" do
      it "correctly converts itself to a string" do
        description = nameless_cohort.to_s
        expect(description).to include("Nameless cohort")
        expect(description).to include("0 samples")
        expect(description).to include("0 conversions")
        expect(description).to include("conversion rate")
        expect(description).to include("95% confidence")
      end
    end
  end
  # bad path tests
  it "raises an error if views is nil" do
    expect { Cohort.new(name: "F", views: nil, conversions: 0) }.to(
      raise_error(ArgumentError, /views .* integer/))
  end

  it "raises an error if views is non-numeric" do
    expect { Cohort.new(name: "F", views: "x", conversions: 0) }.to(
      raise_error(ArgumentError, /views .* integer/))
  end

  it "raises an error if views is negative" do
    expect { Cohort.new(name: "F", views: -1, conversions: 0) }.to(
      raise_error(ArgumentError, /views .* integer/))
  end

  it "raises an error if views is fractional" do
    expect { Cohort.new(name: "F", views: 1.5, conversions: 0) }.to(
      raise_error(ArgumentError, /views .* integer/))
  end

  it "raises an error if conversions is nil" do
    expected_message = /conversions .* integer/
    expect { Cohort.new(name: "F", views: 0, conversions: nil) }.to(
      raise_error(ArgumentError, expected_message))
  end

  it "raises an error if conversions is non-numeric" do
    expected_message = /conversions .* integer/
    expect { Cohort.new(name: "F", views: 0, conversions: "x") }.to(
      raise_error(ArgumentError, expected_message))
  end

  it "raises an error if conversions is negative" do
    expected_message = /conversions .* integer/
    expect { Cohort.new(name: "F", views: 0, conversions: -1) }.to(
      raise_error(ArgumentError, expected_message))
  end

  it "raises an error if conversions is fractional" do
    expected_message = /conversions .* integer/
    expect { Cohort.new(name: "F", views: 0, conversions: 1.5) }.to(
      raise_error(ArgumentError, expected_message))
  end
end
