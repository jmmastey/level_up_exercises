require 'spec_helper'
require_relative 'chi_square_test'

describe 'ChiSquareTest' do
  extend ChiSquareTest
  let(:data) { ABTestData.new(total_samples: 100, conversions: 10) }
  context 'Invalid inputs' do
    it 'nil arguments' do
      expect do
        ChiSquareTest.calculate(nil, nil)
      end.to raise_error('Both inputs cannot be nil')
    end
    let(:array_obj) { [] }
    it 'non instance of ABTestData' do
      expect do
        ChiSquareTest.calculate(array_obj, data)
      end.to raise_error('Both inputs must be instance of ABTestData')

      expect do
        ChiSquareTest.calculate(data, array_obj)
      end.to raise_error('Both inputs must be instance of ABTestData')
    end
  end
  context 'Valid inputs' do
    it {  expect(ChiSquareTest.calculate(data, data)).to eq(0) }
  end
end
