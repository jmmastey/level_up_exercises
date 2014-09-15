require "spec_helper"
require_relative "../cohort.rb"

describe Cohort do
  describe "#initialize" do
    it "must have a name" do
      cohort = Cohort.new("A")
      expect(cohort.name).to eq("A")
    end

    it "raises an error if no name" do
      expect { Cohort.new }.to raise_error ArgumentError
    end
    
    xit "raises an error if conversion/non-conversion are not integers" do
    end

    it "can have conversions and non-conversions set on initialize" do
      cohort = Cohort.new("A", conversions: 10, non_conversions: 11)
      expect(cohort.conversions).to eq(10)
      expect(cohort.non_conversions).to eq(11)
    end

    it "if not set, initially has 0 conversions and nonconversions" do
      cohort = Cohort.new("A")
      expect(cohort.conversions).to eq(0)
      expect(cohort.non_conversions).to eq(0)
    end
  end

  describe "#add_conversion" do
    it "should increase number of conversions by 1" do
      cohort = Cohort.new("A")
      expect { cohort.add_conversion }.to change { cohort.conversions }.by(1)
    end
  end

  describe "#add_non_conversion" do
    it "should incease number of nonconversions by 1" do
      cohort = Cohort.new("A")
      expect { cohort.add_non_conversion }.to change { cohort.non_conversions }.by(1)
    end
  end

  describe "#visitors" do
    it "sample size sums to conversions + nonconversions" do
      cohort = Cohort.new("A")
      expect(cohort.visitors).to eq(0)

      cohort.add_conversion
      cohort.add_conversion
      cohort.add_non_conversion
      expect(cohort.visitors).to eq(3)
    end
  end
end
