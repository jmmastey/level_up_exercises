require 'pry'
require_relative 'spec_helper'
require_relative '../lib/parser'
require_relative '../lib/cohort'
require_relative '../lib/split_test'

describe SplitTest do

  def create_cohort(conversions, non_conversions)
    Cohort.new.tap do |cohort|
      conversions.times     { cohort.add(create_visitor(1)) }
      non_conversions.times { cohort.add(create_visitor(0)) }
    end
  end

  def create_visitor(result)
    Visitor.new('2014-03-20', "n/a", result)
  end

  context "with 2 cohorts" do
    let(:cohort_a) { create_cohort(20, 1) }
    let(:cohort_b) { create_cohort(1, 20) }
    subject(:split_test) { SplitTest.new(cohort_a, cohort_b) }

    it "detects if there's a stat.sig. difference between 2 cohorts" do
      expect(split_test).to be_different
    end

    # TODO: should I be testing the value? Should I be trusting the API
    # and just test the return value to make sure that it plays well
    # with other methods?
    it "calculates a chisquare p value" do
      expect(split_test.chisquare_p_value).to be_within(1e6).of(0.00038)
    end
  end

  context "when a cohort is not large enough" do
    let(:cohort_a) { create_cohort(1, 1) }
    let(:cohort_b) { create_cohort(1, 20) }
    subject(:small_split_test) { SplitTest.new(cohort_a, cohort_b) }

    it "throws an error if you try to test for difference" do
      expect { small_split_test.different? }.to raise_error(
        ABAnalyzer::InsufficientDataError,
      )
    end

    it "throws an error if you try to calculate the p value for a difference" do
      expect { small_split_test.chisquare_p_value }.to raise_error(
        ABAnalyzer::InsufficientDataError,
      )
    end
  end

  context "when cohorts are very similar" do
    let(:cohort_a) { create_cohort(10, 15) }
    let(:cohort_b) { create_cohort(15, 10) }
    subject(:simlar_split_test) { SplitTest.new(cohort_a, cohort_b) }

    it "detects if there's no stat.sig. difference" do
      expect(simlar_split_test).to_not be_different
    end

    it "detects if there's no stat.sig. difference at .8 level" do
      expect(simlar_split_test.chisquare_p_value).to be < 0.8
    end
  end
end
