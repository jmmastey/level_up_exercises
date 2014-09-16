require "spec_helper"
require_relative "../chi_square"
require_relative "../cohort"

describe ChiSquare do
  let(:cohort_a) { Cohort.new("A", conversions: 5, non_conversions: 15) }
  let(:cohort_b) { Cohort.new("B", conversions: 15, non_conversions: 5) }
  let(:cohort_c) { Cohort.new("B", conversions: 18, non_conversions: 2) }
  let(:cohorts) { [cohort_a, cohort_b] }
  let(:chi_square) { ChiSquare.new(cohorts) }

  describe "#initialize" do
    it "accepts an array of two cohorts" do
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
      sig_level = 0.05
      chi_square = ChiSquare.new(cohorts, sig_level)
      expect(chi_square.sig_level).to eq(0.05)
    end

    it "sets significance level to 0.05 if not set" do
      expect(chi_square.sig_level).to eq(0.05)
    end

    it "has a chi square statistic 3.841 at the 0.05 sig level" do
      expect(chi_square.statistic).to eq(3.841)
    end

    it "calculates chi square value properly" do
      expect(chi_square.value).to eq(10)
    end

    it "is statistically significant if value is greater than statistic" do
      expect(chi_square.statistically_significant?).to eq(true)

      chi_square_same = ChiSquare.new([cohort_a, cohort_a])
      chi_square_close = ChiSquare.new([cohort_b, cohort_c])
      expect(chi_square_same.statistically_significant?).to eq(false)
      expect(chi_square_close.statistically_significant?).to eq(false)
    end

    xit "has a chi square value of 6.635 at the 0.01 sig level" do
    end

    xit "it can only accept sig values of 0.5, 0.1, 0.05....." do
    end
  end
end
