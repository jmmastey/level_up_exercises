require_relative '../lib/cohort_data'

describe CohortData do
  let(:file) { '../data_export_2014_06_20_15_59_02.json' }
  let(:cohort_data)  { CohortData.new(file) }

  describe '#intialize' do
    it 'loads cohort data' do
      cohort_data.load_json_data_into_array
      expect(cohort_data.cohort_visits.count).not_to eq 0
    end
  end

  describe '#load_json_data_into_array' do
    it 'returns an array from a json file' do
      expect(cohort_data.load_json_data_into_array).to be_a_kind_of Array
    end
    it 'should not be an empty array' do
      expect(cohort_data.load_json_data_into_array.count).not_to eq 0
    end
  end
end
