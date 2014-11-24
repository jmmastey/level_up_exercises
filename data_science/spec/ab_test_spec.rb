require "spec_helper"
require_relative "../ab_test.rb"

describe ABTest do
  def create_cohort_collection(a, b)
    cohort_a = Cohort.new('A', a[0], a[1])
    cohort_b = Cohort.new('B', b[0], b[1])
    CohortCollection.new([cohort_a, cohort_b]);
  end

  let(:insignificant) do
    create_cohort_collection([40, 100], [62, 112])
  end

  let(:significant_99_5) do
    create_cohort_collection([12, 120], [23, 60])
  end

  let(:significant_90) do
    create_cohort_collection([62, 100], [40, 100])
  end

  context "#initialize" do
    it "raises error when there are no arguments" do
      expect { ABTest.new }.to raise_error ArgumentError
    end

    it "raises error when there are more that one argument" do
      expect { ABTest.new(insignificant, 'B') }.to raise_error(ArgumentError)
    end
  end

  context "when properly initialized with insignificant data" do
    let(:ab_test) { ABTest.new(insignificant) }
    subject { ab_test }

    it "calculates the chi-squared value" do
      expect(ab_test.chi_squared).to be_within(1e-6).of(1.763490909)
    end

    it "tells whether significant or not" do
      expect(ab_test).not_to be_significant
    end

    it "calculates the confidence level" do
      expect(ab_test.confidence_level).to be_within(1e-6).of(0.8158)
    end

    it "displays proper results" do
      result = <<-eos.gsub(/^[\s\t]*/, '')
        ----------------------------------------------------------------------------------------------------
        A | samples:   140, success ratio: 28.57%, 95% confidence interval: (21.09% - 36.05%)
        B | samples:   174, success ratio: 35.63%, 95% confidence interval: (28.52% - 42.75%)
        ----------------------------------------------------------------------------------------------------
        No clear leader at 90.0% confidence level
      eos

      expect(ab_test.to_s).to eq(result)
    end
  end

  context "when properly initialized with significant data (>99.5%)" do
    let(:ab_test) { ABTest.new(significant_99_5) }
    subject { ab_test }

    it "calculates the chi-squared value" do
      expect(ab_test.chi_squared).to be_within(1e-6).of(12.96302091)
    end

    it "calculates whether significant or not" do
      expect(ab_test).to be_significant
    end

    it "calculates the confidence level" do
      expect(ab_test.confidence_level).to be(0.9997)
    end

    it "displays proper results" do
      result = <<-eos.gsub(/^[\s\t]*/, '')
        ----------------------------------------------------------------------------------------------------
        A | samples:   132, success ratio: 9.09%, 95% confidence interval: (4.19% - 14.00%)
        B | samples:    83, success ratio: 27.71%, 95% confidence interval: (18.08% - 37.34%)
        ----------------------------------------------------------------------------------------------------
        Leader is B at 99.97% confidence level
      eos

      expect(ab_test.to_s).to eq(result)
    end
  end

  context "when properly initialized with significant data (>90%)" do
    let(:ab_test) { ABTest.new(significant_90) }
    subject { ab_test }

    it "calculates the chi-squared value" do
      expect(ab_test.chi_squared).to be_within(1e-6).of(3.159214303)
    end

    it "calculates whether significant or not" do
      expect(ab_test).to be_significant
    end

    it "calculates the confidence level" do
      expect(ab_test.confidence_level).to be(0.9245)
    end

    it "displays proper results" do
      result = <<-eos.gsub(/^[\s\t]*/, '')
        ----------------------------------------------------------------------------------------------------
        A | samples:   162, success ratio: 38.27%, 95% confidence interval: (30.79% - 45.76%)
        B | samples:   140, success ratio: 28.57%, 95% confidence interval: (21.09% - 36.05%)
        ----------------------------------------------------------------------------------------------------
        Leader is A at 92.45% confidence level
      eos

      expect(ab_test.to_s).to eq(result)
    end
  end
end
