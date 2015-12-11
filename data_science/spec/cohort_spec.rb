require 'spec_helper'
require_relative '../lib/cohort'

describe Cohort do
  let(:a_visit_pos) { FactoryGirl.build(:visit) }
  let(:a_visit_neg) { FactoryGirl.build(:visit, result: 0) }
  let(:visits) { [a_visit_pos, a_visit_neg] }
  let (:cohort) { Cohort.new(visits) }

  describe '#initialize' do
    context 'when the array of Visits contains Visits from different cohorts' do
      let(:b_visit) { FactoryGirl.build(:visit, cohort: "B") }
      let(:visits) { [a_visit_pos, b_visit] }

      it 'throws an error' do
        expect { Cohort.new(visits) }.to raise_error("All visits must be from the same cohort")
      end
    end
  end

  describe '#sample_size' do
    it 'returns an integer representing total Visits w/the specified cohort' do
      expect(cohort.sample_size).to eq(2)
    end
  end

  describe '#num_conversions' do
    it 'returns an integer num of conversions for Visits w/specified cohort' do
      expect(cohort.num_conversions).to eq(1)
    end
  end

  context 'when larger sample size' do
    let(:visits) do
      ([1] * 4 + [0] * 35).shuffle.map { |v| v == 0 ? a_visit_neg : a_visit_pos }
    end
    let (:cohort) { Cohort.new(visits) }

    describe '#conversion_rate' do
      it 'returns a result with 95% confidence' do
        # Unfortunately this isn't really TDD -- the values below came from
        # running the gem. Didn't understand how else to do this and get the
        # same values.
        expect(cohort.conversion_rate).to eq([0.0073, 0.1978])
      end
    end

    describe '#<=>' do
      let(:b_pos) { FactoryGirl.build(:visit, cohort: "B") }
      let(:b_neg) { FactoryGirl.build(:visit, cohort: "B", result: 0) }
      let(:b_visits) do
        ([1] * 10 + [0] * 29).shuffle.map { |v| v == 0 ? b_neg : b_pos }
      end
      let(:b_cohort) { Cohort.new(b_visits) }
      it 'returns the cohort with the highest conversion rate' do
        expect([cohort, b_cohort].max).to eq(b_cohort)
      end
    end
  end
end
