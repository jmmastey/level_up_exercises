require 'models/timer'
require 'active_support/time'

RSpec.describe Timer do
  context 'default configuration' do
    let(:timer) { Timer.new }

    it 'will not be started' do
      expect(timer).not_to be_started
    end

    it 'will not be detonated' do
      expect(timer).not_to be_detonated
    end
  end

  context 'starting with the default value' do
    let(:timer) do
      timer = Timer.new
      timer.start
      timer
    end

    it 'should be started' do
      expect(timer).to be_started
    end

    it 'should have a deadline set 30 seconds from now' do
      expect(timer.detonation).to be_within(1E-3).of(Time.now + 30.seconds)
    end
  end
end
