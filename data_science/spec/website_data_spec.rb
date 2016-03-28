require 'spec_helper'

describe DataScience::WebsiteData do
  before(:all) do
    @website_data = DataScience::WebsiteData.new("test_data.json")
    @cohort = 'A'
  end

  describe '#sample_size' do
    it 'gives the sample size of a cohort' do
      expect(@website_data.sample_size(@cohort)).to eq(732)
    end
  end

  describe '#conversion_count' do
    it 'gives the conversion count of a cohort' do
      expect(@website_data.conversion_count(@cohort)).to eq(32)
    end
  end

  describe '#non_conversion_count' do
    it 'gives the non-conversion count of a cohort' do
      expect(@website_data.non_conversion_count(@cohort)).to eq(700)
    end
  end

  describe '#format_for_analyzer' do
    it 'formats the data for use by ABAnalyzer' do
      expected = { a: { converted: 32, not_converted: 700 },
                   b: { converted: 13, not_converted: 950 } }
      expect(@website_data.format_for_analyzer).to eq(expected)
    end
  end
end
