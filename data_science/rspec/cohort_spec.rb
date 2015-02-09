require_relative '../cohort'
describe Cohort do
  context 'sad' do
    it 'should raise an error if initialized with nil values' do
      expect {  Cohort.new(nil, []) }.to raise_error
      expect {  Cohort.new("cohort_name", nil) }.to raise_error
    end
  end
end