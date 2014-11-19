require 'spec_helper'
require_relative 'chi_square_test'

describe 'ChiSquareTest' do
  extend ChiSquareTest
  let(:data_a) { ABTestData.new(total_samples: 100, conversions: 10) }
  let(:data_b) { ABTestData.new(total_samples: 40, conversions: 5) }

  context 'when the calcualte returns' do
    it 'has result of 0' do
      expect(ChiSquareTest.calculate(data_a, data_a)).to eq(0)
    end
    it 'has result between 0.186 to 0.187' do
      expect(ChiSquareTest.calculate(data_a, data_b)).to within(0.001).of(0.186)
    end
  end
end
