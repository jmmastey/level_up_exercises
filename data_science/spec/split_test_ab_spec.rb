require_relative 'spec_helper'
RSpec.describe SplitTestAB do
  let(:data) { DataLoader.new('../testabdata_sample.json') }
  let(:splitTestAb) { SplitTestAB.new(data.json_data) }
  NUM_CONVER_A = 13
  NUM_CONVER_B = 10
  COHORTA_ERROR_BAR = [0.26727411833986714, 0.6292776057980639]
  COHORTB_ERROR_BAR = [0.11245469104354977, 0.3753501870052307]
  CONVERA_RATE = 0.4482758620689655
  CONVERB_RATE = 0.24390243902439024
  CONFI_SCORE =  0.07292591052499331

  describe 'Number of conversions for each cohort' do
    it 'returns the number of conversions when given a cohort' do
      expect(splitTestAb.cohorta.conversions).to eq(NUM_CONVER_A)
      expect(splitTestAb.cohortb.conversions).to eq(NUM_CONVER_B)
    end
  end

  describe '#error_bars' do
    it 'returns error bars for each cohort' do
      expect(splitTestAb.cohorta.error_bars).to \
        eq(COHORTA_ERROR_BAR)
      expect(splitTestAb.cohortb.error_bars).to \
        eq(COHORTB_ERROR_BAR)
    end
  end

  describe '#conversion_rate' do
    it 'returns the conversion rate for each cohort' do
      expect(splitTestAb.cohorta.conversion_rate).to \
        eq(CONVERA_RATE)
      expect(splitTestAb.cohortb.conversion_rate).to \
        eq(CONVERB_RATE)
    end
  end

  describe '#confidence_score' do
    it 'checks the chi_square_p score' do
      expect(splitTestAb.confidence_score).to eq(CONFI_SCORE)
    end
  end
end
