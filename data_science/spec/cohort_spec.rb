require 'spec_helper'
require_relative '../lib/cohort'

describe Cohort do
	let(:a_visit_pos) { FactoryGirl.build(:visit) }
	let(:a_visit_neg) { FactoryGirl.build(:visit, result: 0) }
	let(:visits) { [a_visit_pos, a_visit_neg] }
	let (:cohort) { Cohort.new(visits) }

	describe '#initialize' do
		context 'passed an array of only Visits' do

			context 'the array of Visits contains Visits from different cohorts' do
				let(:b_visit) { FactoryGirl.build(:visit, cohort: "B") }
				let(:visits) { [a_visit_pos, b_visit] }

				it 'throws an error' do
					expect{ Cohort.new(visits) }.to raise_error("All visits must be from the same cohort")
				end
			end
			context 'all Visits are from the same cohorts' do
				it 'sets an instance variable "@visits" with the passed in Visits' do
					expect(cohort.visits).to eq(visits)
				end
			end
		end
	end

	describe '#sample_size' do
		it 'returns an integer representing total Visits with the specified cohort' do
			expect(cohort.sample_size).to eq(2)
		end
	end

	describe '#num_conversions' do
		it 'returns an integer representing conversions for Visits with the specified cohort' do
			expect(cohort.num_conversions).to eq(1)
		end
	end

	context 'larger sample size' do
		let(:visits) { [a_visit_pos, a_visit_neg, a_visit_neg, a_visit_neg,
											a_visit_neg, a_visit_neg, a_visit_neg, a_visit_neg,
											a_visit_neg, a_visit_neg, a_visit_neg, a_visit_neg,
											a_visit_pos, a_visit_neg, a_visit_neg, a_visit_neg,
											a_visit_neg, a_visit_pos, a_visit_neg, a_visit_neg,
											a_visit_neg, a_visit_neg, a_visit_neg, a_visit_neg,
											a_visit_neg, a_visit_neg, a_visit_neg, a_visit_neg,
											a_visit_neg, a_visit_neg, a_visit_neg, a_visit_neg,
											a_visit_neg, a_visit_neg, a_visit_neg, a_visit_neg,
											a_visit_neg, a_visit_neg, a_visit_pos] }
		let (:cohort) { Cohort.new(visits) }

		describe '#conversion_rate' do
			it 'returns a result with 95% confidence' do
				expect(cohort.conversion_rate).to eq([0.007346948784984583, 0.19778125634322052])
			end
		end

		describe '#current_leader' do
			let(:b_visit_pos){ FactoryGirl.build(:visit, cohort: "B") }
			let(:b_visit_neg){ FactoryGirl.build(:visit, cohort: "B", result: 0) }
			let(:b_visits) { [b_visit_pos, b_visit_neg, b_visit_neg, b_visit_neg,
											b_visit_neg, b_visit_neg, b_visit_neg, b_visit_neg,
											b_visit_neg, b_visit_neg, b_visit_neg, b_visit_neg,
											b_visit_pos, b_visit_neg, b_visit_neg, b_visit_neg,
											b_visit_neg, b_visit_pos, b_visit_neg, b_visit_neg,
											b_visit_neg, b_visit_neg, b_visit_neg, b_visit_pos,
											b_visit_pos, b_visit_pos, b_visit_pos, b_visit_pos,
											b_visit_pos, b_visit_pos, b_visit_pos, b_visit_pos,
											b_visit_pos, b_visit_pos, b_visit_neg, b_visit_neg,
											b_visit_neg, b_visit_neg, b_visit_pos] }
			let(:b_cohort) { Cohort.new(b_visits) }			
			it 'returns the cohort with the highest conversion rate' do
				expect(cohort.current_leader(b_cohort)).to eq(b_cohort)
			end
		end
	end

	describe '#'
end