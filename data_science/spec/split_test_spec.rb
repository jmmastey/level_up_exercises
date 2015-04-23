require 'spec_helper'

describe SplitTest do
  let(:converter) { CohortConverter.new('spec/test_data.json') }
  let(:test) { described_class.new(converter.cohorts) }

  describe '#new' do
    it 'takes a collection of cohorts and returns a SplitTest object' do
      expect(test).instance_of? described_class
    end
  end

  describe '#cohorts' do
    it 'returns a collection of cohorts' do
      expect(test).instance_of? described_class
    end
  end

  describe '#conversion_rates'
    it 'returns a collection of conversion rates, one for each cohort' do
      expect(test.conversion_rates[0]).to eq(0.5728155339805825)
    end

  describe '#confidence' do
    it 'finds min/max predictions for a given confidence level' do
      expect(test.confidence[0]).to eq([0.5300927453027154, 0.6155383226584495])
    end
  end

  describe '#chi_square' do
    it 'returns the p values for a chi_square test' do
      expect(test.chi_square).to eq(5.1514348342607263e-14)
    end
  end
end
