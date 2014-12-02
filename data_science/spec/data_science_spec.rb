require 'spec_helper'
require_relative '../data_science'
require_relative '../json_parser'

describe DataScience do
  let(:parser) { JsonParser.new }
  let(:parse_data_value) { parser.parse_data('source_data.json') }
  let(:calc) { DataScience.new(parse_data_value) }

  context 'when data calculator is created' do
    it 'It calculates the sample size for each cohort' do
      expect(calc.total_samples('A')).to eq(1349)
      expect(calc.total_samples('B')).to eq(1543)
    end

    it 'It calculates the conversions for each cohort' do
      expect(calc.conversions('A')).to eq(47)
      expect(calc.conversions('B')).to eq(79)
    end

    it 'It calculates the conversion rate for each cohort' do
      expect(calc.conversion_rate('A')).to eq(0.035)
      expect(calc.conversion_rate('B')).to eq(0.051)
    end

    it 'It calculates distribution range for each cohort' do
      expect(calc.distribution_range('A')).to match_array([0.025, 0.045])
      expect(calc.distribution_range('B')).to match_array([0.04, 0.062])
    end

    it 'It calculates confidence_level(chisquare)' do
      expect(calc.chisquare_p).to eq(0.961)
    end

    it 'The winner is B' do
      expect(calc.leader('A', 'B')).to eq('B')
    end

  end
end
