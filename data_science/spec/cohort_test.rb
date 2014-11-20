require 'spec_helper'
require 'visitor'
require 'cohort'

describe Cohort do
	let(:visitor1) { Visitor.new({ date: '2014-03-20', cohort: "A", result: 0 }) }
	let(:visitor2) { Visitor.new({ date: '2013-12-29', cohort: "A", result: 1 }) }
	let(:cohort) { Cohort.new(visitor1, visitor2) }
	subject {'cohort'}

	it "should have many visitors" do
		expect(cohort.members.length).to eq(2)
	end

	it "should have a total sample size" do 
		expect(cohort.sample_size).to eq(2)
	end

	it "should have 1 conversion" do
		expect(cohort.conversions).to eq(1)
	end

end	