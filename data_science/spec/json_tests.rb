require 'spec_helper'

describe JsonParser do

	let(:test) { JsonParser.new("source_data.json") }
  let(:json_length) { test.json_length }
	let(:parsed_data) { test.parsed_a_b_data }
	let(:a_no_of_trials) { parsed_data[:a_group].values.inject(:+) }
	let(:b_no_of_trials) { parsed_data[:b_group].values.inject(:+) }
  let(:total_trials) { a_no_of_trials + b_no_of_trials }

  context "Upon creation" do
    it "should create a JsonParser instance" do
      expect(test).to be_an_instance_of(JsonParser)
    end

    it "should return exception for nonexistent file" do
      expect { JsonParser.new("does_not_exist.json") }.to raise_error
    end

    it "should throw exception for empty json files" do
      expect { JsonParser.new("empty.json") }.to raise_error
    end
    it "should have parsed data with the same # of trials as json input" do
      expect(total_trials).to be == json_length
    end

  	it "should have at least one trial for each cohort" do
  		expect(a_no_of_trials).to be > 0
  		expect(b_no_of_trials).to be > 0
  	end
  end
end
