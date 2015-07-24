require_relative '../lib/cohort'
require_relative '../lib/visit'

RSpec.describe Cohort  do
  let(:name) { "A" }
  let(:passing_visit) { Visit.new(1, '10-10-15') }
  let(:failing_visit) { Visit.new(0, '10-10-15') }
  let(:standard_error) { Math.sqrt(0.25 * 0.75 / 40) }

  describe '.new' do
    it 'should be a Cohort class' do
      expect(Cohort.new(name)).to be_a(Cohort)
    end
  end

  describe '#conversions' do
    it 'should return the number of passing conversions' do
      cohort = Cohort.new(name)
      5.times { cohort.add_visit(passing_visit) }
      3.times { cohort.add_visit(failing_visit) }
      expect(cohort.conversions).to eq(5)
    end
  end

  describe '#failed_conversions' do
    it 'should return the number of failed conversions' do
      cohort = Cohort.new(name)
      10.times { cohort.add_visit(passing_visit) }
      6.times { cohort.add_visit(failing_visit) }
      expect(cohort.failed_conversions).to eq(6)
    end
  end

  describe '#sample_size' do
    it 'should return the total number of visits' do
      cohort = Cohort.new(name)
      15.times { cohort.add_visit(passing_visit) }
      10.times { cohort.add_visit(failing_visit) }

      expect(cohort.sample_size).to eq(25)
    end
  end

  describe '#conversion_rate' do
    it 'should return the conversion rate based on poss count' do
      cohort = Cohort.new(name)
      10.times { cohort.add_visit(passing_visit) }
      30.times { cohort.add_visit(failing_visit) }

      expect(cohort.conversion_rate).to eq(0.25)
    end
  end

  describe '#standard_error' do
    it 'should return the standard error based on conversion rate and size' do
      cohort = Cohort.new(name)
      10.times { cohort.add_visit(passing_visit) }
      30.times { cohort.add_visit(failing_visit) }

      expect(cohort.standard_error).to eq(standard_error)
    end
  end

  describe '#conversion_rate_range' do
    it 'should return the lower and upper conversion rate boundaries' do
      cohort = Cohort.new(name)
      2.times { cohort.add_visit(passing_visit) }
      2.times { cohort.add_visit(failing_visit) }

      expect(cohort.conversion_rate_range).to eq([0.25, 0.75])
    end
  end

  describe '#generate_pass_fail_info' do
    it 'should generate a hash with pass and fail conversion counts' do
      cohort = Cohort.new(name)
      2.times { cohort.add_visit(passing_visit) }
      10.times { cohort.add_visit(failing_visit) }
      values = { pass: 2, fail: 10 }

      expect(cohort.generate_pass_fail_info).to eq(values)

    end
  end
end
