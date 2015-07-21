require 'rspec'
require_relative '../lib/cohort'

describe 'Cohort' do
  let(:cohort) { Cohort.new 10, 15 }
  describe '#new' do
    context 'when initializing a Cohort' do
      it 'should not be nil' do
        expect(cohort).to_not be_nil
      end
    end
  end
  describe '#total_sample_size do' do
    it 'should keep track of all the different results in the cohort' do
      expect(cohort.total_sample_size).to eq 25
    end
  end
  it 'should keep track of count per result' do
    expect(cohort.success_count).to eq 10
  end
  it 'should keep track of count per result' do
    expect(cohort.failure_count).to eq 15
  end
end
