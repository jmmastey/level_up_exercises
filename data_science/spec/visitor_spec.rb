require "spec_helper"
require_relative "../lib/visitor"

describe Visitor do
	let (:visitor) {Visitor.new(date: '2014-03-20', cohort: "A", result: 0)}
	
	it 'is part of a test cohort' do 
		expect(visitor.cohort).to match(/A/ || /B/)
	end

	it 'visted on a date' do 
		expect(visitor.visit_date.class).to eq(Date)
	end

	it 'has a registration status' do 
		expect(visitor.result)
	end
end