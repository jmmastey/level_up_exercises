require_relative '../cohort_statistics.rb'
require_relative '../data_statistics.rb'
require 'abanalyzer'

describe CohortStatistics do
  let(:filename) { 'test.json' }
  let(:cohort_data) { DataStatistics.new(filename).cohort_data }
  let(:cohort_stat_A) { CohortStatistics.new("A", cohort_data) }

  describe '#cohort_size' do
    it 'calculates the size of the inputted cohort' do
      size = 11
      expect(cohort_stat_A.cohort_size).to eq(size)
    end
  end

  describe '#cohort_confidence_interval' do
    it 'calculates the confidence interval at 95%' do
      ab_confidence = ABAnalyzer.confidence_interval(5, 11, 0.95)
      bottom = cohort_stat_A.cohort_confidence_interval[0]
      top = cohort_stat_A.cohort_confidence_interval[1]
      expect(ab_confidence[0].round(3)).to eq(bottom)
      expect(ab_confidence[1].round(3)).to eq(top)
    end
  end

  describe '#cohort_chi_square' do
    it 'convert cohort stat to a chi square testable hash' do
      values = { "A" => { converted: 5, not_con: 6 } }
      expect(values).to eq(cohort_stat_A.values)
    end
  end

  describe "#cohort_conversion_freq" do
    context 'calculates the number of people converted' do
      it 'counts the number of ones' do
        converted = 5
        expect(cohort_stat_A.converted).to eq(converted)
      end
    end

    context 'calculates the number of people not converted' do
      let(:not_converted) { cohort_stat_A.not_con }
      it 'counts the number of 0' do
        expect(cohort_stat_A.not_con).to eq(not_converted)
      end
    end
  end
end
