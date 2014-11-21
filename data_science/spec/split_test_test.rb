require_relative 'spec_helper'
require_relative 'visitor'
require_relative 'cohort'
require_relative 'split_test'

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

		it "has a confidence level that 'leader' is actually better than random" do
			expect(split_test.different?).to be true
		end
	end

end