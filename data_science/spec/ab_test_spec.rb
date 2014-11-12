require "spec_helper"
require_relative "../ab_test.rb"

describe ABTest do
  let(:insignificant) do
    {
      "A" => { success: 40, failure: 100 },
      "B" => { success: 62, failure: 112 },
    }
  end

  let(:significant_99_5) do
    {
      "A" => { success: 12, failure: 120 },
      "B" => { success: 23, failure: 60 },
    }
  end

  let(:significant_90) do
    {
      "A" => { success: 62, failure: 100 },
      "B" => { success: 40, failure: 100 },
    }
  end

  context "#initialize" do
    it "raises error when there are no arguments" do
      expect { ABTest.new }.to raise_error ArgumentError
    end

    it "raises error when there are more that one argument" do
      expect { ABTest.new(insignificant, 'B') }.to raise_error(ArgumentError)
    end

    it "raises error when the first argument is not a valid matrix" do
      expect { ABTest.new(5) }.to raise_error InvalidABMatrixError
    end
  end

  context "when properly initialized with insignificant data" do
    let(:ab_test) { ABTest.new(insignificant) }
    subject { ab_test }

    it { is_expected.to be_instance_of ABTest }

    it "calculates the chi-squared value" do
      expect(ab_test.chi_squared).to be_within(1e-6).of(1.763490909)
    end

    it "tells whether significant or not" do
      expect(ab_test.significant?).to be(false)
    end

    it "calculates the confidence level" do
      expect(ab_test.confidence_level).to be(nil)
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

  context "when properly initialized with significant data (99.5%)" do
    let(:ab_test) { ABTest.new(significant_99_5) }
    subject { ab_test }

    it { is_expected.to be_instance_of ABTest }

    it "calculates the chi-squared value" do
      expect(ab_test.chi_squared).to be_within(1e-6).of(12.96302091)
    end

    it "calculates whether significant or not" do
      expect(ab_test.significant?).to be(true)
    end

    it "calculates the confidence level" do
      expect(ab_test.confidence_level).to be(0.995)
    end

    it "displays proper results" do
      result = <<-eos.gsub(/^[\s\t]*/, '')
        ----------------------------------------------------------------------------------------------------
        A | No. of Samples:   132, success_ratio: 9.09%, 95% confidence interval: (4.19% - 14.00%)
        B | No. of Samples:    83, success_ratio: 27.71%, 95% confidence interval: (18.08% - 37.34%)
        ----------------------------------------------------------------------------------------------------
        Leader is B at 99.5% confidence level
      eos

      expect(ab_test.to_s).to eq(result)
    end
  end

  context "when properly initialized with significant data (90%)" do
    let(:ab_test) { ABTest.new(significant_90) }
    subject { ab_test }

    it { is_expected.to be_instance_of ABTest }

    it "calculates the chi-squared value" do
      expect(ab_test.chi_squared).to be_within(1e-6).of(3.159214303)
    end

    it "calculates whether significant or not" do
      expect(ab_test.significant?).to be(true)
    end

    it "calculates the confidence level" do
      expect(ab_test.confidence_level).to be(0.90)
    end

    it "displays proper results" do
      result = <<-eos.gsub(/^[\s\t]*/, '')
        ----------------------------------------------------------------------------------------------------
        A | No. of Samples:   162, success_ratio: 38.27%, 95% confidence interval: (30.79% - 45.76%)
        B | No. of Samples:   140, success_ratio: 28.57%, 95% confidence interval: (21.09% - 36.05%)
        ----------------------------------------------------------------------------------------------------
        Leader is A at 90.0% confidence level
      eos

      expect(ab_test.to_s).to eq(result)
    end
  end
end
