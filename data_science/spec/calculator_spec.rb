require_relative 'spec_helper'

describe Calculator do
  let(:calculator) { Calculator.new('data_export_2014_06_20_15_59_02.json') }

  context 'with data for split testing' do
    it 'should calculate sample size' do
      expect(calculator.sample_size('A')).to eq(1349)
      expect(calculator.sample_size('B')).to eq(1543)
    end

    it 'should calculate conversions' do
      expect(calculator.conversions('A')).to eq(47)
      expect(calculator.conversions('B')).to eq(79)
    end

    it 'should calculate conversion rate' do
      expect(calculator.conversion_rate('A')).to eq(0.0348)
      expect(calculator.conversion_rate('B')).to eq(0.0512)
    end

    it 'should calculate standard error' do
      expect(calculator.standard_error('A')).to eq(0.005)
      expect(calculator.standard_error('B')).to eq(0.0056)
    end

    it 'should calculate distribution range' do
      expect(calculator.distribution_range('A')).to match_array([0.025, 0.0446])
      expect(calculator.distribution_range('B')).to match_array([0.0402, 0.0622])
    end

    it 'should calculate confidence level' do
      expect(calculator.confidence_level).to eq(96.84)
    end
  end
end
