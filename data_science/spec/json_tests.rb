require 'spec_helper'

describe JsonParser do

#	it "should return exception for invalid file" do
# 		expect { JsonParser.new("blahksd.json") }.to raise_error
#	end
#
#	it "should throw exception for nonexistent method" do 
#		expect { JsonParser.new.blah }.to raise_error
#	end

#	it "should create a hash with valid json input" do
#		test = JsonParser.new("source_data.json")
#		expect(test.data_hash.length).to be > 0
#	end
	let(:test) { JsonParser.new("source_data.json") }
	let(:parsed_data) { test.parsed_ab_data }
	let(:a_data) { parsed_data[:a_group] }
	let(:b_data) { parsed_data[:b_group] }
	let(:a_trials) { a_data.values.inject(:+) }
	let(:b_trials) { b_data.values.inject(:+) }

	it "should contain results for each group" do
		expect(a_data).to include(:pass, :fail)
		expect(b_data).to include(:pass, :fail)
		expect(a_data[:pass]).to be >= 0
		expect(a_data[:fail]).to be >= 0
		expect(b_data[:pass]).to be >= 0
		expect(b_data[:fail]).to be >= 0
	end

	it "should have at least one trial for each group" do
		expect(a_trials).to be > 0
		expect(b_trials).to be > 0
	end
end
