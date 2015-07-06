require 'data_loader'
require 'test_data'

RSpec.describe TestData do
  let(:data_source) { DataLoader.new('data/test_data.json') }
  let(:test_data) { TestData.new(data_source.load_data) }

  context 'a test data sample' do
    it 'will determine the sample size' do
      expect(test_data.sample_size).to eq(23)
    end

    it 'will determine the amount of members in a group' do
      expect(test_data.group_count('cohort', 'B')).to eq(13)
      expect(test_data.group_count('cohort', 'A')).to eq(10)
    end

    it 'will determine the number of conversions in a group' do
      expect(test_data.conversions_count('cohort', 'B', 'result')).to eq(2)
      expect(test_data.conversions_count('cohort', 'A', 'result')).to eq(0)
    end
  end
end
