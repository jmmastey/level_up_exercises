require_relative 'spec_helper'
require_relative '../lib/cohort'
require_relative '../lib/split_test'

describe Cohort do

  context "with only 1 cohort" do
    let(:visitor1) { Visitor.new('2014-03-20', "A", 0) }
    let(:visitor2) { Visitor.new('2013-12-29', "A", 1) }

    subject('cohort') { Cohort.new.add(visitor1).add(visitor2) }

    it "has a total sample size of visitors" do
      expect(cohort.sample_size).to eq(2)
    end

    it "has 1 conversion" do
      expect(cohort.conversions).to eq(1)
    end

    it "calculates the conversion percentage" do
      expect(cohort.conversion_percentage).to eq(0.5)
    end

    describe "confidence interval" do

      # NOTE: This ensures that methods dependent on confidence interval
      # receive the correct return value
      # TODO: Should I be testing class?
      it "returns a an array of two float values" do
        expect(cohort.confidence_interval).to respond_to(:each)
        expect(cohort.confidence_interval[0].class).to eq(Float)
        expect(cohort.confidence_interval[1].class).to eq(Float)
      end

      # NOTE: This test was more for the experience and memory
      it "calls on the confidence_interval method from ABAnalyzer" do
        require 'abanalyzer'
        expect(ABAnalyzer).to receive(:confidence_interval).with(1, 2, 0.95)
        cohort.confidence_interval
      end

      # NOTE: This test was more for the experience and memory.
      # Normally, you don't test a method'simplementation
      it "calculates a 95% confidence interval for the conversion rate" do
        expect(cohort.confidence_interval[0]).to be_within(1e-4).of(-0.1929)
        expect(cohort.confidence_interval[1]).to be_within(1e-4).of(1.1929)
      end
    end

    context "with an empty cohort" do
      subject(:empty_cohort) { Cohort.new }

      it "has a sample size of 0" do
        expect(empty_cohort.sample_size).to eq(0)
      end

      it "has no conversions" do
        expect(empty_cohort.conversions).to eq(0)
      end

      it "calculates a 0% conversion rate" do
        expect(empty_cohort.conversion_percentage).to eq(0)
      end

      # TODO: Do we want it to raise an error?
      it "raises an error if you calculate the confidence interval" do
        expect { empty_cohort.confidence_interval }.to raise_error
      end
    end
  end
end
