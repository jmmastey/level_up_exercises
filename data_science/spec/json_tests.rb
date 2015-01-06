require 'spec_helper'

describe JsonParser do
	# let(:parser) { JsonParser.new }
	it "should return exception for invalid file" do
 		expect { JsonParser.new("blahksd.json") }.to raise_error
	end

	it "should throw exception for nonexistent method" do 
		expect { JsonParser.new.blah }.to raise_error
	end

#	it "should create a hash with valid json input" do
#		test = JsonParser.new("source_data.json")
#		expect(test.data_hash.length).to be > 0
#	end

	it "should contain results for each group" do
		test = JsonParser.new("source_data.json")
		expect(test.data_hash).to include(:a_group, :b_group)
		puts test.data_hash[:a_group]
		puts test.data_hash[:a_group].length
		expect(test.data_hash[:a_group]).to include(:pass, :fail)
		expect(test.data_hash[:b_group]).to include(:pass, :fail)
		expect(test.data_hash[:a_group][:pass]).to be >= 0
		expect(test.data_hash[:a_group][:fail]).to be >= 0
		expect(test.data_hash[:a_group][:pass]).to be >= 0
		expect(test.data_hash[:a_group][:fail]).to be >= 0

	end

end
