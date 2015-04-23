require 'spec_helper'

describe CohortConverter do
  let(:data) { described_class.new('spec/test_data.json') }

  describe '#new' do
    it 'takes a json object and returns a CohortConverter object' do
      expect(data).to be_a(described_class)
    end
  end

  describe '#cohorts' do
    it 'returns a collection of cohorts.' do
      data.cohorts.each do |cohort|
        expect(cohort).to be_a(Cohort)
      end
    end
  end
end
