require_relative '../data_analyzer'

describe 'data analyzer' do
  context 'when conducting pre-calculated chi-squared test' do
    it 'should return 0.96' do
      test_values = {}
      test_values[:cohort_a] = { conversions: 41, fails: 259 }
      test_values[:cohort_b] = { conversions: 55, fails: 545 }
      response = DataAnalyzer.confidence(test_values)
      expect(response).to eql(0.96)
    end
  end

  context 'when calculating pre-calculated conversion rate' do
    it 'should return .18 +/- 0.01' do
      successes = 711
      trials = 4000
      response = DataAnalyzer.conversion_rate(successes, trials)
      expect(response[:conversion_rate]).to eql(0.18)
      expect(response[:error]).to eql(0.01)
    end
  end
end
