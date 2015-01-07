require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe DataScience::Cohort do
  let (:cohort) { load_cohort_data }

  describe '#new' do
    it 'assigns its name the value passed to new' do
      expect(cohort.name).to eq('foo')
    end
  end

  describe '#add_sample' do
    it 'increments samples' do
      expect {
        cohort.add_sample(1)
      }.to change{
        cohort.trials
      }.from(1349).to(1350)
    end

    context 'when a conversion took place' do
      it 'increments conversions' do
        expect {
          cohort.add_sample(1)
        }.to change{
          cohort.conversions
        }.from(47).to(48)
      end
    end

    it 'calculates the conversion rate' do
      expect(cohort.conversion_rate).to eq(0.035)
    end
  end

  describe '#standard_error' do
    it 'returns its standard error' do
      expect(cohort.standard_error).to eq(0.005)
    end
  end

  describe '#range_for_conversion_rate' do
    it 'returns the range for 95% conversion rate confidence' do
      expect(cohort.range_for_conversion_rate).to eq(0.01)
    end
  end


private

  def load_cohort_data
    cohort   = DataScience::Cohort.new('foo')
    raw_data = File.read(File.expand_path("data/source_data.json"))
    sample   = JSON.parse(raw_data)

    sample.each do |sample|
      next unless sample['cohort'] == 'A'

      cohort.add_sample(sample['result'])
    end

    cohort
  end
end
