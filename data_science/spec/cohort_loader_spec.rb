require_relative '../lib/cohort_loader'

RSpec.describe CohortLoader do
  filename = 'spec/data_export.json'
  let(:cohort_loader) do
    loader = CohortLoader.new(filename)
    loader.load
    loader
  end

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
      loader = cohort_loader

      expect(loader.sample_size('A')).to eq(2)
      expect(loader.sample_size('B')).to eq(2)
      expect(loader.sample_size).to eq(4)
    end
  end

  context '.conversions' do
    it 'should return the count of positive conversions for cohort' do
      loader = cohort_loader

      expect(loader.conversions('A')).to eq(1)
      expect(loader.conversions('B')).to eq(1)
      expect(loader.conversions).to eq(2)
    end
  end

  context '.conversion_rate' do
    it 'should determine the conversion rate for cohort' do
      loader = cohort_loader

      expect(loader.conversion_rate('A')).to eq(0.5)
      expect(loader.conversion_rate('B')).to eq(0.5)
      expect(loader.conversion_rate).to eq(0.5)
    end
  end

  context '.standard_error' do
    it 'should determine the standard error for cohort' do
      loader = cohort_loader

      expect(loader.standard_error('A')).to eq(Math.sqrt(0.125))
      expect(loader.standard_error('B')).to eq(Math.sqrt(0.125))
      expect(loader.standard_error).to eq(0.25)
    end
  end

  context '.conversion_rate_range' do
    it 'should determine the conversion rate range for cohort' do
      loader = cohort_loader

      range = [0.5 - Math.sqrt(0.125), 0.5 + Math.sqrt(0.125)]

      expect(loader.conversion_rate_range('A')).to eq(range)
      expect(loader.conversion_rate_range('B')).to eq(range)
    end
  end

  context '.to_ab_format' do
    it 'should return a hash with groups A and B pass/fail numbers' do
      loader = cohort_loader

      values = loader.to_ab_format
      expect(values).to be_a(Hash)
      expect(values.key?('A')).to be true
      expect(values.key?('B')).to be true
      expect(values['A'].key?(:pass)).to be true
      expect(values['A'].key?(:fail)).to be true
      expect(values['B'].key?(:pass)).to be true
      expect(values['B'].key?(:fail)).to be true
    end 
  end
end
