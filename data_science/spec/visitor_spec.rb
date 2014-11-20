require "spec_helper"
require "visitor.rb"

describe Visitor do
	it 'is part of a test cohort' do 
		visitor = Visitor.new(date: '2014-03-20', cohort: "A", result: 0)
		expect(visitor.cohort).to match(/A/ || /B/)
	end

	it 'visted on a date' do 
		visitor = Visitor.new(date: '2014-03-20', cohort: "A", result: 0)
		expect(visitor.visit_date.class).to eq(Date)
	end

	it 'has a registration status' do 
		visitor = Visitor.new(date: '2014-03-20', cohort: "A", result: 0)
		expect(visitor.result)
	end
end