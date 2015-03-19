require_relative '../data_import'

describe 'data import' do
  context 'when importing' do
    it 'should have 900 entries' do
      data_set = DataImport.new('test_data_1.json')
      expect(data_set.data_hash.count).to eql(900)
    end
  end

  context 'when formatting data' do
    it 'should format to a hash with 1 key for each cohort' do
      data_set = DataImport.new('test_data_1.json')
      expect(data_set.format.keys.count).to eql(2)
    end
  end

  context 'when calculating confidence' do
    it 'should return 0.96' do
      data_set = DataImport.new('test_data_1.json')
      expect(data_set.confidence).to eql(0.96)
    end
  end

  context 'when calculating conversion rate' do
    it 'should return .18 +/- .01 for both groups' do
      data_set = DataImport.new('test_data_2.json')
      response = data_set.conversion_rates
      expect(response[:cohort_a][:conversion_rate]).to eql(0.18)
      expect(response[:cohort_a][:error]).to eql(0.01)
      expect(response[:cohort_b][:conversion_rate]).to eql(0.18)
      expect(response[:cohort_b][:error]).to eql(0.01)
    end
  end
end
