require_relative '../lib/cohort'

RSpec.describe Cohort  do
  context '#new' do
    it 'should be a Cohort class' do
      expect(Cohort.new).to be_a(Cohort)
    end
  end

  context '.conversion' do
    it 'should return true if it was a conversion' do
      cohort = Cohort.new
      cohort.result = 1
      expect(cohort.conversion?).to be true
    end

    it 'should return false if it was not a conversion' do
      cohort = Cohort.new
      cohort.result = 0
      expect(cohort.conversion?).to be false
    end
  end
end
