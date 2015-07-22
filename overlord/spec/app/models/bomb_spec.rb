require 'models/bomb'
require 'models/trigger'
require 'models/timer'

RSpec.describe Bomb do
  context 'with compliant components' do
    let(:trigger) { Trigger.new }
    let(:timer) { Timer.new }
    let(:bomb) { Bomb.new(trigger: trigger, timer: timer) }

    it 'will allow the bomb to be provisioned' do
      expect { bomb }.not_to raise_error
    end

    it 'will know the number of bomb components' do
      expect(bomb.components.size).to eq(2)
    end

    it 'will know its specific components' do
      expect(bomb.components[:trigger]).to eq(trigger)
      expect(bomb.components[:timer]).to eq(timer)
    end

    it 'will not be detonated' do
      expect(bomb).not_to be_detonated
    end
  end

  context 'with non-compliant components' do
    let(:bad_trigger) { Object.new }
    let(:bomb) { Bomb.new(trigger: bad_trigger) }

    it 'will not allow the bomb to be created' do
      expect { bomb }.to raise_error(BadComponentError,
        'Bomb components must respond to detonated messages.')
    end
  end

  context 'a bomb that has detonated' do
    let(:detonated_trigger) do
      trigger = Trigger.new
      def trigger.detonated?
        true
      end
      trigger
    end

    let(:bomb) { Bomb.new(trigger: detonated_trigger) }

    it 'will be detonated' do
      expect(bomb).to be_detonated
    end
  end
end
