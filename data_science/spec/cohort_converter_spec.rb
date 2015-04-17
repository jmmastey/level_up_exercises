require 'spec_helper'

describe CohortConverter do 
  let(:data) { CohortConverter.new('spec/test_data.json') }

  describe '#new' do
    it 'takes a json object and returns a CohortConverter object' do
      expect(data).instance_of? CohortConverter
    end
  end

  describe '#cohorts' do
    it 'returns a collection of cohorts.' do
      data.cohorts.each do |cohort|
        expect(cohort).instance_of? Cohort
      end
    end
  end
end
