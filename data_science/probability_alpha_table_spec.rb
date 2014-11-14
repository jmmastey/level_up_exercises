require 'spec_helper'
require_relative 'probability_alpha_table'

describe 'ProbabilityAlphaTable' do
  extend ProbabilityAlphaTable
  context 'Invalid inputs' do
    it '0 arguments' do
      expect do
        ProbabilityAlphaTable.significant_level
      end.to raise_error(ArgumentError)
    end

    it 'non exisit df value' do
      expect do
        ProbabilityAlphaTable.significant_level(0, 222)
      end.to raise_error('The given df does not exist')

      expect do
        ProbabilityAlphaTable.significant_level(6, 222)
      end.to raise_error('The given df does not exist')
    end

    it 'out of range' do
      expect do
        ProbabilityAlphaTable.significant_level(1, -0)
      end.to raise_error('The value out of range')
    end

    it do
      expect do
        ProbabilityAlphaTable.significant_level(1, Float::INFINITY)
      end.to raise_error('The value out of range')
    end
  end

  context 'Valid inputs' do
    it do
      expect(ProbabilityAlphaTable.significant_level(1, 0.455)).to eq(0.5)
    end
    it do
      expect(ProbabilityAlphaTable.significant_level(1, 10.955)).to eq(0.001)
    end

  end
end
