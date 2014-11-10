require "spec_helper"
require_relative "../cohort.rb"

describe Cohort do
  context "#initialize" do
    it "raises error when there are no arguments" do
      expect { Cohort.new }.to raise_error ArgumentError
    end

    it "raises error when there are more that one argument" do
      expect { Cohort.new('A', 'B') }.to raise_error ArgumentError
    end

    it "raises error when the first argument is not a string" do
      expect { Cohort.new(5) }.to raise_error ArgumentError
    end
  end

  context "when properly initialized" do
    let(:cohort) { Cohort.new('A') }
    subject { cohort }

    it { is_expected.to be_instance_of Cohort }
    it { is_expected.to respond_to(:size).with(0).argument }
    it { is_expected.to respond_to(:num_converts).with(0).argument }
    it { is_expected.to respond_to(:num_non_converts).with(0).argument }
    it { is_expected.to respond_to(:conversion_ratio).with(0).argument }
    it { is_expected.to respond_to(:add_converts).with(1).argument }
    it { is_expected.to respond_to(:add_non_converts).with(1).argument }
    it { is_expected.to respond_to(:standard_error).with(0).argument }
    it { is_expected.to respond_to(:confidence_interval).with(0).argument }

    it "has a sample size of zero" do
      expect(cohort.size).to eq(0)
    end

    it "has zero converts" do
      expect(cohort.num_converts).to eq(0)
    end

    it "has zero non-converts" do
      expect(cohort.num_non_converts).to eq(0)
    end

    it "has a name provided in the initialization" do
      expect(cohort.name).to eq('A')
    end

    it "calculate standard error" do
      expect(cohort.standard_error).to be_within(1e-10).of(0.00)
    end

    it "calculates correct low with 95% confidence" do
      expect(cohort.confidence_interval[0]).to be_within(1e-10).of(0.00)     
    end

    it "calculates correct high with 95% confidence" do
      expect(cohort.confidence_interval[1]).to be_within(1e-10).of(0.00) 
    end
  end

  context "when converts added" do
    let(:cohort) do
      Cohort.new('A').tap do |c|
        c.add_converts(4)
      end
    end

    it "increases number of converts" do
      expect(cohort.num_converts).to be(4)
    end

    it "increases number of size" do
      expect(cohort.size).to be(4)
    end

    it "calculates conversion_ratio" do
      expect(cohort.conversion_ratio).to be_within(1e-10).of(1.00)
    end


  end

  context "when non-converts added" do
    let(:cohort) do
      Cohort.new('A').tap do |c|
        c.add_non_converts(5)
      end
    end

    it "increases number of non converts" do
      expect(cohort.num_non_converts).to be(5)
    end

    it "increases number of size" do
      expect(cohort.size).to be(5)
    end

    it "calculates conversion ratio" do
      expect(cohort.conversion_ratio).to be_within(1e-10).of(0.00)
    end
  end

  context "when both converts and non-converts added" do
    let(:cohort) do
      Cohort.new('A').tap do |c|
        c.add_non_converts(35)
        c.add_converts(40)
      end
    end

    it "increases number of size" do
      expect(cohort.size).to be(75)
    end

    it "calculates current conversion_ratio" do
      expect(cohort.conversion_ratio).to be_within(1e-10).of(0.5333333333333333)
    end

    it "calculate standard error" do
      expect(cohort.standard_error).to be_within(1e-10).of(0.05760658398584764)
    end

    it "calculates correct low with 95% confidence" do
      expect(cohort.confidence_interval[0]).to be_within(1e-10).of(0.42042442872107194)     
    end

    it "calculates correct high with 95% confidence" do
      expect(cohort.confidence_interval[1]).to be_within(1e-10).of(0.6462422379455947) 
    end
  end
end