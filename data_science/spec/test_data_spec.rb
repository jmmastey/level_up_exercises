require 'data_loader'
require 'test_data'

RSpec.describe TestData do
  let(:data_source) { DataLoader.new('data/test_data.json') }
  let(:test_data) { TestData.new(data_source.load_data, 'cohort') }

  context 'a test data sample' do
    it 'will determine the sample size' do
      expect(test_data.sample_size).to eq(23)
    end

    it 'will determine the number of trials for group members' do
      expect(test_data.trial_size('B')).to eq(13)
      expect(test_data.trial_size('A')).to eq(10)
    end

    it 'will determine the number of conversions in a group' do
      expect(test_data.conversions_count('B')).to eq(2)
      expect(test_data.conversions_count('A')).to eq(0)
    end

    it 'will determine all group members' do
      expect(test_data.group_members).to eq(%w(B A))
    end

    it 'will calculate the conversion percentage of group members' do
      expect(test_data.conversion_percentage('B')).to eq(0.15384615384615385)
      expect(test_data.conversion_percentage('A')).to eq(0)
    end

    it 'will calculate the standard error' do
      expect(test_data.standard_error('B')).to eq(0.1961337731926865)
      expect(test_data.standard_error('A')).to eq(0.0)
    end
  end
end
