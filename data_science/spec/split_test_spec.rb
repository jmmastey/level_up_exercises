require 'spec_helper'

describe SplitTest do 
  let(:converter) { CohortConverter.new('spec/test_data.json') }
  let(:test) { SplitTest.new(converter.cohorts) }

  describe '#new' do
    it 'takes a collection of cohorts and returns a SplitTest object' do
      expect(test).instance_of? SplitTest
    end
  end

  describe '#cohorts' do
    it 'returns a collection of cohorts' do
      expect(test).instance_of? SplitTest
    end
  end

  describe '#conversion_rates'
    it 'returns a collection of conversion rates, one for each cohort' do
      expect(test.conversion_rates[0]).to eq(0.9833333333333333)
    end

  describe '#confidence' do
    it 'finds min/max predictions for a given confidence level' do
      expect(test.confidence[0]).to eq([0.968846875179678, 0.9978197914869885])
    end
  end

  describe '#chi_square' do
    it 'returns the p values for a chi_square test' do
      expect(test.chi_square).to eq(0.0)
    end
  end
end
