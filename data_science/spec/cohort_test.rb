require 'spec_helper'
require 'visitor'
require 'cohort'
require 'split_test'

describe Cohort do

	context "with only 1 cohort" do
		let(:visitor1) { Visitor.new({ date: '2014-03-20', cohort: "A", result: 0 }) }
		let(:visitor2) { Visitor.new({ date: '2013-12-29', cohort: "A", result: 1 }) }
		
		let(:cohort) { Cohort.new.add(visitor1).add(visitor2) }
		let(:empty_cohort) { Cohort.new }

		subject {'cohort'}

		it "has a total sample size of visitors" do
			expect(cohort.sample_size).to eq(2)
		end

		it "has 1 conversion" do
			expect(cohort.conversions).to eq(1)
		end

		it "has a percentage of conversion " do
			expect(cohort.conversion_percentage).to eq(0.5)
		end

		it "has a 0 percent conversion rate for no data" do
			expect(empty_cohort.conversion_percentage).to eq(0)
		end

		it "has a 95% confidence interval for the conversion rate" do
			expect(cohort.confidence_interval[0]).to be_within(1e-4).of(-0.1929)
			expect(cohort.confidence_interval[1]).to be_within(1e-4).of(1.1929)
		end
	end
end	

describe SplitTest do

	context "with 2 cohorts" do 
		let(:vis1) { Visitor.new({ date: '2014-03-20', cohort: "A", result: 0 }) }
		let(:vis2) { Visitor.new({ date: '2013-12-29', cohort: "A", result: 0 }) }
		let(:vis3) { Visitor.new({ date: '2014-03-20', cohort: "A", result: 0 }) }
		let(:vis4) { Visitor.new({ date: '2013-12-29', cohort: "A", result: 1 }) }
		let(:vis5) { Visitor.new({ date: '2014-03-20', cohort: "A", result: 0 }) }
		let(:vis6) { Visitor.new({ date: '2013-12-29', cohort: "A", result: 1 }) }
		let(:vis7) { Visitor.new({ date: '2014-03-20', cohort: "B", result: 1 }) }
		let(:vis8) { Visitor.new({ date: '2013-12-29', cohort: "B", result: 1 }) }
		let(:vis9) { Visitor.new({ date: '2014-03-20', cohort: "B", result: 1 }) }
		let(:vis10){ Visitor.new({ date: '2013-12-29', cohort: "B", result: 1 }) }
		let(:vis11){ Visitor.new({ date: '2014-03-20', cohort: "B", result: 0 }) }
		let(:vis12){ Visitor.new({ date: '2013-12-29', cohort: "B", result: 1 }) }

		let(:cohort_A) { Cohort.new.add(vis1)
					  			   .add(vis2)
					  			   .add(vis3)
					  			   .add(vis4)
					  			   .add(vis5)
					  			   .add(vis6) }

		let(:cohort_B) { Cohort.new.add(vis7)
					  			   .add(vis8)
					  			   .add(vis9)
					  			   .add(vis10)
					  			   .add(vis11)
					  			   .add(vis12) }

		let(:split_test) { SplitTest.new(cohort_A, cohort_B)}

		it "has a confidence level that 'leader' is actually better than random" do
			expect(split_test.diff?).to be_true
		end
	end

end