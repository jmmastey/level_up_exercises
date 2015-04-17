require 'spec_helper'

describe Cohort do
  attributes =
      {
          :name => 'A',
          :successes => '900',
          :attempts => '1200'
      }
  let(:cohort) { Cohort.new(attributes) }

  describe '#new' do
    it 'takes attributes and returns a Cohort object' do
      expect(cohort).instance_of? Cohort
    end
  end

  describe '#name' do
    it 'returns the name of the cohort' do
      expect(cohort.name).to eq('A')
    end
  end

  describe '#successes' do
    it 'returns the successes of the cohort' do
      expect(cohort.successes).to eq(900)
    end
  end

  describe '#attempts' do
    it 'returns the attempts of the cohort' do
      expect(cohort.attempts).to eq(1200)
    end
  end

  describe '#failures' do
    it 'returns the failures of the cohort' do
      expect(cohort.failures).to eq(300)
    end
  end

  describe '#conversion_rate' do
    it 'returns the conversion_rate of the cohort' do
      expect(cohort.conversion_rate).to eq(0.75)
    end
  end

  describe '#add_attempt' do
    it 'adds an attempt to the cohort' do
      cohort.add_attempt
      expect(cohort.attempts).to eq(1201)
    end
  end

  describe '#add_success' do
    it 'adds an success to the cohort' do
      cohort.add_success
      expect(cohort.successes).to eq(901)
    end
  end
end
