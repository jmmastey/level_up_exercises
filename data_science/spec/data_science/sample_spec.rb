require 'spec_helper'
  
describe Sample do
  
  cohort = {}
  cohort['date'] = '2014-03-20'
  cohort['cohort'] = 'B'
  cohort['result'] = '0'
  cohort_test = Sample.new(cohort)

  test_sample = []
  test_sample << cohort_test

  let(:sample) {Sample.create_cohort('test.json')}

  context 'When parse data' do
    it "returns a collection of Samples" do
      expect(sample.first.class).to eq(Sample)
    end
    it "checks the date" do
      expect(sample.first.date).to eq(test_sample.first.date)
    end
    it "Checks the cohort" do 
      expect(sample.first.cohort).to eq(test_sample.first.cohort)
    end
    it "Checs the result" do
      expect(sample.first.result).to eq(test_sample.first.result)
    end
  end
end
