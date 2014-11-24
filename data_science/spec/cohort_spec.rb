require "spec_helper"
require_relative "../cohort.rb"

describe Cohort do
  context "#initialize" do
    it "raises error when there are no arguments" do
      expect { Cohort.new }.to raise_error ArgumentError
    end

    # it "raises error when there are more that one argument" do
    #   expect { Cohort.new('A', 'B') }.to raise_error ArgumentError
    # end

    it "raises error when the first argument is nil" do
      expect { Cohort.new(nil) }.to raise_error ArgumentError
    end
  end

  context "when properly initialized" do
    let(:cohort) { Cohort.new('A') }
    subject { cohort }

    it "has a sample size of zero" do
      expect(cohort.size).to eq(0)
    end

    it "has zero successes" do
      expect(cohort.successes).to eq(0)
    end

    it "has zero failures" do
      expect(cohort.failures).to eq(0)
    end

    it "has a name provided in the initialization" do
      expect(cohort.name).to eq('A')
    end

    it "calculate standard error" do
      expect(cohort.standard_error).to be_within(1e-10).of(0.00)
    end

    it "calculates correct low with 95% confidence" do
      expect(cohort.confidence_interval[:lower]).to be_within(1e-10).of(0.00)
    end

    it "calculates correct high with 95% confidence" do
      expect(cohort.confidence_interval[:upper]).to be_within(1e-10).of(0.00)
    end

    it "outputs the stats of the cohort" do
      expect(cohort.to_s).to eq("This cohort does not contain any results")
    end
  end

  context "when initialized with successes only" do
    let(:cohort) do
      cohort = Cohort.new('A', 4)
    end

    it "increases number of successes" do
      expect(cohort.successes).to be(4)
    end

    it "increases number of size" do
      expect(cohort.size).to be(4)
    end

    it "calculates success_ratio" do
      expect(cohort.success_ratio).to be_within(1e-10).of(1.00)
    end

    it "displays stats" do
      expect(cohort.to_s).to eq("A | samples:     4, success ratio: 100.00%, 95% confidence interval: (100.00% - 100.00%)")
    end
  end

  context "when initialized with failures only" do
    let(:cohort) do
      cohort = Cohort.new('A', 0, 5)
    end

    it "increases number of failures" do
      expect(cohort.failures).to be(5)
    end

    it "increases number of size" do
      expect(cohort.size).to be(5)
    end

    it "calculates success ratio" do
      expect(cohort.success_ratio).to be_within(1e-10).of(0.00)
    end

    it "displays stats" do
      expect(cohort.to_s).to eq("A | samples:     5, success ratio: 0.00%, 95% confidence interval: (0.00% - 0.00%)")
    end
  end

  context "when initialized with both successes and failures" do
    let(:cohort) do
      cohort = Cohort.new('A', 40, 35)
    end

    it "increases number of size" do
      expect(cohort.size).to be(75)
    end

    it "calculates current success_ratio" do
      expect(cohort.success_ratio).to be_within(1e-10).of(0.5333333333333333)
    end

    it "calculate standard error" do
      expect(cohort.standard_error).to be_within(1e-10).of(0.05760658398584764)
    end

    it "calculates correct low with 95% confidence" do
      expect(cohort.confidence_interval[:lower]).to be_within(1e-10)
        .of(0.42042442872107194)
    end

    it "calculates correct high with 95% confidence" do
      expect(cohort.confidence_interval[:upper]).to be_within(1e-10)
        .of(0.6462422379455947)
    end

    it "displays stats" do
      expect(cohort.to_s).to eq("A | samples:    75, success ratio: 53.33%, 95% confidence interval: (42.04% - 64.62%)")
    end
  end
end
