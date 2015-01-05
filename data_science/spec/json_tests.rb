require 'spec_helper'

	describe JsonParser do

		it "should return exception for invalid file" do
			a = JsonParser.new
			puts a
			puts "test"
			a.start
			# expect { JsonParser.new("blah.json") }.to raise_error
		end
		
	end