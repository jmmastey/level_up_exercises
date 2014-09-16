require "spec_helper"
require_relative "../chi_square"
require_relative "../cohort"

describe ChiSquare do
  let(:cohort_a) { Cohort.new("A", conversions: 5, non_conversions: 15) }
  let(:cohort_b) { Cohort.new("B", conversions: 15, non_conversions: 5) }
 # let(:chi_square) { ChiSquare.new(4,3,2,1) }

  describe "#initialize" do
    it "accepts an array of two cohorts" do
      cohorts = [ cohort_a, cohort_b]
      chi_square = ChiSquare.new(cohorts)
      expect(chi_square.cohorts[0].name).to eq("A")
      expect(chi_square.cohorts[1].conversions).to eq(15)
    end

    it "raises an error if not input with two cohorts" do
      cohorts_1 = [cohort_a]
      cohorts_3 = [cohort_a, cohort_a, cohort_a]
      cohorts_ints = [1, 2]

      expect { ChiSquare.new(cohorts_1) }.to raise_error ArgumentError
      expect { ChiSquare.new(cohorts_3) }.to raise_error ArgumentError
      expect { ChiSquare.new(cohorts_ints) }.to raise_error ArgumentError
    end

    xit "can accept a significance level on input" do
      cohorts = [ cohort_a, cohort_b]
      sig_level = 0.05
      chi_square = ChiSquare.new(cohorts, sig_level)
      expect(chi_square.sig_level).to eq(0.05)
    end

    it "sets significance level to 0.05 if not set" do
      cohorts = [ cohort_a, cohort_b]
      chi_square = ChiSquare.new(cohorts)
      expect(chi_square.sig_level).to eq(0.05)
    end

    it "has a chi square statistic 3.841 at the 0.05 sig level" do
      cohorts = [ cohort_a, cohort_b]
      chi_square = ChiSquare.new(cohorts)
      expect(chi_square.statistic).to eq(3.841)
    end

    xit "has a chi square value of 6.635 at the 0.01 sig level" do
    end

    xit "it can only accept sig values of 0.5, 0.1, 0.05....." do
    end
  end
end
