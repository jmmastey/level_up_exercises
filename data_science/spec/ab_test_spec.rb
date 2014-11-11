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
      "A" => { success: 40, failure: 100 },
      "B" => { success: 62, failure: 100 },
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
  end
end
