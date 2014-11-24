require_relative 'spec_helper'
require_relative '../lib/visitor'
require_relative '../lib/cohort'
require_relative '../lib/split_test'

describe SplitTest do

  context "with 2 cohorts" do

    def create_cohort(conversions, non_conversions)
      Cohort.new.tap do |cohort|
        conversions.times     { cohort.add(create_visitor(1)) }
        non_conversions.times { cohort.add(create_visitor(0)) }
      end
    end

    def create_visitor(result)
      Visitor.new(date: '2014-03-20', cohort: "n/a", result: result)
    end

    let(:cohort_a) { create_cohort(20, 1) }
    let(:cohort_b) { create_cohort(1, 20) }
    let(:split_test) { SplitTest.new(cohort_a, cohort_b) }

    it "has a confidence level" do
      expect(split_test).to be_different
    end

    it "has a chisquare p value" do
      expect(split_test.chisquare_p_value).to be_within(1e6).of(0.00038)
    end
  end
end
