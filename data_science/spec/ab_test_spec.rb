require "spec_helper"
require_relative "../ab_test.rb"

describe ABTest do
  def results_to_cohort_collection(results)
    collection = results.map do |name, data|
      cohort = Cohort.new(name)
      cohort.successes = data[:success]
      cohort.failures  = data[:failure]
      cohort
    end

    CohortCollection.new(collection)
  end

  let(:insignificant) do
    results = {
      "A" => { success: 40, failure: 100 },
      "B" => { success: 62, failure: 112 },
    }

    results_to_cohort_collection(results)
  end

  let(:significant_99_5) do
    results = {
      "A" => { success: 12, failure: 120 },
      "B" => { success: 23, failure: 60 },
    }

    results_to_cohort_collection(results)
  end

  let(:significant_90) do
    results = {
      "A" => { success: 62, failure: 100 },
      "B" => { success: 40, failure: 100 },
    }

    results_to_cohort_collection(results)
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
        A | No. of Samples:   140, success_ratio: 28.57%, 95% confidence interval: (21.09% - 36.05%)
        B | No. of Samples:   174, success_ratio: 35.63%, 95% confidence interval: (28.52% - 42.75%)
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
        A | No. of Samples:   132, success_ratio: 9.09%, 95% confidence interval: (4.19% - 14.00%)
        B | No. of Samples:    83, success_ratio: 27.71%, 95% confidence interval: (18.08% - 37.34%)
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
        A | No. of Samples:   162, success_ratio: 38.27%, 95% confidence interval: (30.79% - 45.76%)
        B | No. of Samples:   140, success_ratio: 28.57%, 95% confidence interval: (21.09% - 36.05%)
        ----------------------------------------------------------------------------------------------------
        Leader is A at 92.45% confidence level
      eos

      expect(ab_test.to_s).to eq(result)
    end
  end
end
