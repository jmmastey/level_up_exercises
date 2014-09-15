require "spec_helper"
require_relative "../cohort.rb"

describe Cohort do
  describe "#initialize" do
    it "must have a name" do
      cohort = Cohort.new("A")
      expect(cohort.name).to be("A")
    end

    it "raises an error if no name" do
      expect { Cohort.new }.to raise_error ArgumentError
    end

    it "initially has 0 conversions and nonconversions" do
      cohort = Cohort.new("A")
      expect(cohort.conversions).to be(0)
      expect(cohort.non_conversions).to be(0)
    end
  end

  describe "#add_conversion" do
    it "should increase number of conversions by 1" do
    end
  end

  describe "#add_non_conversion" do
    it "should incease number of nonconversions by 1" do
    end
  end

  describe "#sample_size" do
    it "sample size sums to conversions + nonconversions" do
    end
  end
end
