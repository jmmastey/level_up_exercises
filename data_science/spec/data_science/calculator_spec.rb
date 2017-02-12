require 'spec_helper'

describe Calculator do

  let(:calculator) { Calculator.new('sample.json') }

  context 'When the calculator is initialized' do

    it'Caclulates sample size for each cohort' do
      expect(calculator.sample_size('A')).to eq(57)
      expect(calculator.sample_size('B')).to eq(61)
    end

    it 'Calculates the no of conversions for each cohort' do
      expect(calculator.sample_conversions('A')).to eq(6)
      expect(calculator.sample_conversions('B')).to eq(15)
    end

    it 'Calculates the conversion rate for each cohort' do
      expect(calculator.conversion_rate('A')).to be_within(0.0001) .of(0.1053)
      expect(calculator.conversion_rate('B')).to be_within(0.0001) .of(0.2459)
    end

    it 'Calculates distribution limit for each cohort' do
      expect(calculator.distribution_limit('A')).to match_array([0.074, 0.136])
      expect(calculator.distribution_limit('B')).to match_array([0.222, 0.27])
    end
    
    it 'Returns the leader' do
      expect(calculator.leader).to eq('B')
    end

    it 'Runs the chisquare test and returns the result' do
      expect(calculator.chi_square).to eq(0.046)
    end

  end
end
  
