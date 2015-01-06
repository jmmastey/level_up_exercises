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
  let(:json_length) { test.json_length }
	let(:parsed_data) { test.parsed_ab_data }
	let(:a_data) { parsed_data[:a_group] }
	let(:b_data) { parsed_data[:b_group] }
	let(:a_no_of_trials) { a_data.values.inject(:+) }
	let(:b_no_of_trials) { b_data.values.inject(:+) }
  let(:total_trials) { a_no_of_trials + b_no_of_trials }
  let(:a_conversion) { a_data[:pass].to_f / a_no_of_trials }
  let(:b_conversion) { b_data[:pass].to_f / b_no_of_trials }

  it "should have valid conversion data" do
    expect(total_trials).to be == json_length
    expect(a_conversion).to be_between(0, 1)
    expect(b_conversion).to be_between(0, 1)
  end

	it "should have at least one trial for each group" do
		expect(a_no_of_trials).to be > 0
		expect(b_no_of_trials).to be > 0
	end
end
