require 'data_loader'
require 'test_data'

RSpec.describe TestData do
  context 'Test Data Favors A' do
    let(:data_source) { DataLoader.new('data/test_data_too_small.json') }
    let(:test_data) { TestData.new(data_source.load_data, 'cohort') }

    it 'will determine the sample size' do
      expect(test_data.sample_size).to eq(4)
    end

    it 'will determine the number of trials for group members' do
      expect(test_data.trial_size('B')).to eq(2)
      expect(test_data.trial_size('A')).to eq(2)
    end

    it 'will determine the number of conversions in a group' do
      expect(test_data.conversions_count('B')).to eq(1)
      expect(test_data.conversions_count('A')).to eq(1)
    end

    it 'will determine all group variants' do
      expect(test_data.group_variants).to eq(%w(A B))
    end

    it 'will calculate the conversion percentage of group members' do
      expect(test_data.conversion_percentage('B')).to eq(0.5)
      expect(test_data.conversion_percentage('A')).to eq(0.5)
    end

    it 'will calculate the standard error' do
      expect(test_data.standard_error('B')).to eq(0.6929646455628166)
      expect(test_data.standard_error('A')).to eq(0.6929646455628166)
    end

    it 'will calculate the goodness-of-fit' do
      expect { test_data.goodness_of_fit }.to raise_error(
        ABAnalyzer::InsufficientDataError)
    end

    it 'will determine the variant percentages' do
      expect(test_data.variant_percents.first).to eq(['A', 0.5])
      expect(test_data.variant_percents.last).to eq(['B', 0.5])
    end

    it 'will indicate the data favors A' do
      expect { test_data.favored_variant }.to raise_error(
        ABAnalyzer::InsufficientDataError)
    end
  end
end
