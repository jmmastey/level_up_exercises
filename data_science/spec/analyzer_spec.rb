require 'spec_helper'

describe DataScience::Analyzer do
  before(:all) do
    data = DataScience::WebsiteData.new("test_data.json")
    @analyzer = DataScience::Analyzer.new(data)
    @cohort = 'B'
  end
  
  describe '#conversion_rate' do
    it 'gives the conversion rate for a cohort' do
      expect(@analyzer.conversion_rate(@cohort)).to be_within(0.0001).of(0.0135)
    end
  end
  
  describe '#conversion_rate_error_bar' do
    it 'gives the conversion rate error bar for a cohort' do
      interval = 0.95
      error_bar = @analyzer.conversion_rate_error_bar(@cohort, interval)
      expect(error_bar[0]).to be_within(0.0001).of(0.0062)
      expect(error_bar[1]).to be_within(0.0001).of(0.0208)
    end
  end
  
  describe '#p_value' do
    it 'gives the p-value for the website data' do
      expect(@analyzer.p_value).to be_within(0.0001).of(0.0001)
    end
  end
  
  describe '#different?' do
    it 'tells if results are statistically significantly different' do
      expect(@analyzer.different?).to be true
    end
  end
end