require_relative 'spec_helper'
require_relative '../lib/visitor'
require_relative '../lib/cohort'
require_relative '../lib/split_test'

describe SplitTest do

	context "with 2 cohorts" do 
		let(:cohort_A) do
			cohort = Cohort.new
			20.times { cohort.add(Visitor.new({ date: '2014-03-20', cohort: "A", result: 0 })) }
			1.times { cohort.add(Visitor.new({ date: '2014-03-20', cohort: "A", result: 1 })) }
			cohort
		end

		let(:cohort_B) do
			cohort = Cohort.new
			1.times { cohort.add(Visitor.new({ date: '2014-03-20', cohort: "B", result: 0 })) }
			20.times { cohort.add(Visitor.new({ date: '2014-03-20', cohort: "B", result: 1 })) }
			cohort
		end

		let(:split_test) { SplitTest.new(cohort_A, cohort_B)}

		it "has a confidence level" do
			expect(split_test.different?).to be true
		end

		it "has a chisquare p value" do
			expect(split_test.chisquare_p_value).to be_within(1e6).of(0.00038)
		end
	end
end