require 'rspec'
require 'spec_helper'
require_relative 'data_science.rb'
require_relative 'json_parser.rb'

describe DataScience do
  data = JsonParser.new
  parse_data_value = data.parse_data('source_data.json')
  p parse_data_value

  let(:calc) { DataScience.new(parse_data_value) }

  context 'when data calculator is created' do
    it 'should calculate the sample size for each cohort' do
      expect(calc.total_samples('A')).to eq(1349)
      expect(calc.total_samples('B')).to eq(1543)
    end

    it 'should calculate the conversions for each cohort' do
      expect(calc.conversions('A')).to eq(47)
      expect(calc.conversions('B')).to eq(79)
    end

    it 'should calculate the conversion rate for each cohort' do
      expect(calc.conversion_rate('A')).to eq(0.035)
      expect(calc.conversion_rate('B')).to eq(0.051)
    end

    it 'should calculate distribution range for each cohort' do
      expect(calc.distribution_range('A')).to match_array([0.025, 0.045])
      expect(calc.distribution_range('B')).to match_array([0.04, 0.062])
    end

    it 'should calculate confidence_level (chisquare) ' do
      expect(calc.chisquare_p).to eq(0.961)
    end

    it 'should be winner of A' do
      expect(calc.leader('A', 'B')).to eq('B')
    end

  end
end
