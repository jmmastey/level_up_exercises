require_relative 'spec_helper'

RSpec.describe SplitTestAB do
  let(:data) { LoadData.new('../testabdata_sample.json') }
  let(:ab_test_split) { SplitTestAB.new(data.json_data) }

  describe 'Total Sample Size' do
    it 'returns 70 for our test data' do
      expect(data.total_sample_size).to eq(70)
    end
  end

  describe 'Number of conversions for each cohort' do
    it 'returns the number of conversions when given a cohort' do
      expect(ab_test_split.conversiona).to eq(13)
      expect(ab_test_split.conversionb).to eq(10)
    end
  end

  describe 'Get conversion rate for cohort' do
    it 'returns conversion rate for each cohort' do
      expect(ab_test_split.conversion_rate(ab_test_split.conversiona,ab_test_split.nonconversiona)).to \
       eq([0.26727411833986714, 0.6292776057980639])
      expect(ab_test_split.conversion_rate(ab_test_split.conversionb,ab_test_split.nonconversionb)).to \
       eq([0.11245469104354977, 0.3753501870052307])
    end
  end

  describe 'Accept or reject Null Hypothesis that Current leader is better' do
    it 'checks the chi_square_p score' do
      expect(ab_test_split.confidence_score).to eq(0.07292591052499331)
    end
  end
end
