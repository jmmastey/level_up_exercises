require_relative '../lib/visit'

RSpec.describe Visit do
  let(:passing_visit) { Visit.new(1, '07-25-15') }
  let(:failing_visit) { Visit.new(0, '07-25-15') }

  describe '.new' do
    it 'should be a Visit class' do
      expect(passing_visit).to be_a(Visit)
    end

    it 'should take in result and date' do
      visit = Visit.new(1, '05-10-15')
      expect(visit.result).to eq(1)
      expect(visit.date).to eql('05-10-15')
    end
  end

  describe '#conversion?' do
    it 'should return true if result is 1' do
      expect(passing_visit.conversion?).to be(true)
    end

    it 'should return false if the result is 0' do
      expect(failing_visit.conversion?).to be(false)
    end
  end
end
