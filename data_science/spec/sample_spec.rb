require_relative 'spec_helper'

describe Sample do
  sample = {}
  sample['date'] = '2014-03-20'
  sample['cohort'] = 'B'
  sample['result'] = 0

  let(:sample_object) { Sample.new(sample) }

  context 'reads a data sample' do
    it 'should have date' do
      expect(sample_object.date).to eq(sample['date'])
    end
    it 'should have cohort' do
      expect(sample_object.cohort).to eq(sample['cohort'])
    end
    it 'should have result' do
      expect(sample_object.result).to eq(sample['result'])
    end
  end
end
