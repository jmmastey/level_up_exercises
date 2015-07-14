require_relative '../lib/cohort_loader'

RSpec.describe CohortLoader do
  filename = 'spec/data_export.json'

  context '#new' do
    it 'should take in a filename' do
      expect { CohortLoader.new }.to raise_error(ArgumentError)
      expect(CohortLoader.new(filename)).to be_a(CohortLoader)
    end
  end

  context '.load' do
    it 'should successfully parse the json file' do
      cohort_loader = CohortLoader.new(filename)
      expect { cohort_loader.load }.not_to raise_error
      expect(cohort_loader.load).not_to be_nil
    end
  end

  context '.sample_size' do
    it 'should give the sample size according for cohort' do
      cohort_loader = CohortLoader.new(filename)
      cohort_loader.load

      expect(cohort_loader.sample_size('A')).to eq(2)
      expect(cohort_loader.sample_size('B')).to eq(2)
      expect(cohort_loader.sample_size).to eq(4)
    end
  end

  context '.conversions' do
    it 'should return the count of positive conversions for cohort' do
      cohort_loader = CohortLoader.new(filename)
      cohort_loader.load

      expect(cohort_loader.conversions('A')).to eq(1)
      expect(cohort_loader.conversions('B')).to eq(1)
      expect(cohort_loader.conversions).to eq(2)
    end
  end
end
