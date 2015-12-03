require_relative '../lib/analyzer'
require_relative 'spec_helper'

describe Analyzer do
	let(:values) { { :a_cohort => { :positive => 4, :negative => 34 },
								 :b_cohort => { :positive => 10, :negative => 29 }
								} }
	describe '.better_than_random_confidence' do
		it 'returns the level to which current leader is better than random' do
			#Also not really TDD... used the gem to get this value. Didn't know how to 
			#otherwise do it. I used the simple calculator linked in readme and couldn't
			#get the same number out of the gem.
			expect(Analyzer.better_than_random_confidence(values)).to eq(2.955765482081272)
		end
	end
end