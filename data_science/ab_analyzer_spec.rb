require 'spec_helper'
require_relative 'ab_analyzer'

describe ABAnalyzer do
  it 'the error is raised when create object with passing empty data' do
    expect { ABAnalyzer.new([]) }.to raise_error(NoMethodError)
  end

  context 'when object is instantiated' do
    let(:analyzer) do
      test_data = { A: { total_samples: 1000, conversions: 50 },
                    B: { total_samples: 1000, conversions: 30 } }
      ABAnalyzer.new(test_data)
    end
    it 'has conversion_rate of ~5.0 for varation A' do
      expect(analyzer.conversion_rate(:A)).to be_within(0.1).of(5.0)
    end

    it 'has standard error of ~0.0054 for varation A' do
      expect(analyzer.standard_error(:A)).to be_within(0.0001).of(0.0068)
    end

    it 'has distribution_range between 3.65 to 6.35 for variation A' do
      expect(analyzer.distribution_range(:A)).to include(3.65, 6.35)
    end

    it 'has confidence_level of 50' do
      expect(analyzer.confidence_level).to eq(95)
    end

    it 'has winner of A' do
      expect(analyzer.winner).to eq('A')
    end
  end
end
