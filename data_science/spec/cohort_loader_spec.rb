require_relative '../lib/cohort_loader'

RSpec.describe CohortLoader do
  let(:filename) { 'spec/data_export.json' }
  let(:loader) { CohortLoader.new(filename).tap(&:load) }
  let(:standard_error) { Math.sqrt(0.125) }
  let(:total_standard_error) { 0.25 }

  describe '.new' do
    it 'should take in a filename' do
      expect { CohortLoader.new }.to raise_error(ArgumentError)
      expect(CohortLoader.new(filename)).to be_a(CohortLoader)
    end
  end

  describe '#load' do
    it 'should successfully parse the json file' do
      cohort_loader = CohortLoader.new(filename)
      expect { cohort_loader.load }.not_to raise_error
    end
  end

  describe '#sample_size' do
    it 'should give the sample size according for cohort' do
      expect(loader.sample_size('A')).to eq(2)
      expect(loader.sample_size('B')).to eq(2)
    end

    it 'should give the sample size of all cohorts' do
      expect(loader.sample_size).to eq(4)
    end
  end

  describe '#conversions' do
    it 'should return the count of positive conversions for cohort' do
      expect(loader.conversions('A')).to eq(1)
      expect(loader.conversions('B')).to eq(1)
    end

    it 'should return the count of positive conversions for all cohorts' do
      expect(loader.conversions).to eq(2)
    end
  end

  describe '#conversion_rate' do
    it 'should determine the conversion rate for cohort' do
      expect(loader.conversion_rate('A')).to eq(0.5)
      expect(loader.conversion_rate('B')).to eq(0.5)
    end

    it 'should determine the conversion rate for all cohorts' do
      expect(loader.conversion_rate).to eq(0.5)
    end
  end

  describe '#standard_error' do
    it 'should determine the standard error for cohort' do
      expect(loader.standard_error('A')).to eq(standard_error)
      expect(loader.standard_error('B')).to eq(standard_error)
    end

    it 'should determine the standard error for all cohorts' do
      expect(loader.standard_error).to eq(total_standard_error)
    end
  end

  describe '#conversion_rate_range' do
    it 'should determine the conversion rate range for cohort' do
      range = [0.5 - Math.sqrt(0.125), 0.5 + Math.sqrt(0.125)]

      expect(loader.conversion_rate_range('A')).to eq(range)
      expect(loader.conversion_rate_range('B')).to eq(range)
    end
  end

  describe '#to_ab_format' do
    it 'should return a hash with groups A and B pass/fail numbers' do
      values = loader.to_ab_format
      expect(values).to be_a(Hash)
      expect(values.keys).to include('A')
      expect(values.keys).to include('B')
      expect(values['A'].keys).to include(:pass, :fail)
      expect(values['B'].keys).to include(:pass, :fail)
    end
  end
end
