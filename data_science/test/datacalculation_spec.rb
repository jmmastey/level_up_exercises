require 'spec_helper'
require '../datacalculation'

describe DataCalculation do
  let(:data) do
    { 'A' => { total: 500.0, conversion: 340.0 },
      'B' => { total: 800.0, conversion: 620.0 } }
  end
  let(:data_calc) { DataCalculation.new(data) }
  context 'when data calculator is created' do
    it 'will have total sample size' do
      expect(data_calc.total_size('A')).to eq(500)
    end
    it 'with invalid group name it will give error' do
      expect { data_calc.total_size('C') }.to raise_error(NoMethodError)
      expect { data_calc.number_of_conversion('C') }.to raise_error(NoMethodError)
      expect { data_calc.conversion_rate('C') }.to raise_error(NoMethodError)
    end
    it 'has number of converted samples' do
      expect(data_calc.number_of_conversion('A')).to eq(340)
    end
    it 'calculates the conversion rate, given the cohort letter' do
      expect(data_calc.conversion_rate('A')).to eq(0.68)
    end
    it 'outputs the lower and higher level of confidence interval' do
      expect(data_calc.confidence_interval('A').first).to eq(63.91)
      expect(data_calc.confidence_interval('A').last).to eq(72.09)
    end
    it 'outputs the confidence level of the sample' do
      expect(data_calc.confidence_level).to eq(0.86)
    end
  end
end
