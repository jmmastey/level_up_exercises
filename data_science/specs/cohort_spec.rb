require_relative 'spec_helper'

describe Cohort do
  let(:cohort) { Cohort.new(10, 15) }

  describe '#new' do
    context 'when initializing a Cohort' do
      it 'does not raise' do
        expect { cohort }.not_to raise_error
      end
    end
  end

  describe '#total_sample_size' do
    it 'should keep track of all the different results in the cohort' do
      expect(cohort.total_sample_size).to eq 25
    end
  end

  describe '#success_count' do
    it 'should keep track of count per result' do
      expect(cohort.success_count).to eq 10
    end
  end

  describe '#failure_count' do
    it 'should keep track of count per result' do
      expect(cohort.failure_count).to eq 15
    end
  end
end
