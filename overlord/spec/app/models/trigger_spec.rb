require 'models/trigger'

RSpec.describe Trigger do
  context 'default configuration' do
    let(:trigger) { Trigger.new }

    it 'will not be active' do
      expect(trigger).to be_deactivated
    end
  end

  context 'activation' do
    let(:trigger) { Trigger.new }

    it 'requires a valid activation code' do
      trigger.activate('1234')
      expect(trigger).to be_activated
    end
  end

  context 'deactivation' do
    let(:trigger) { Trigger.new }

    it 'requires a valid deactivation code' do
      trigger.deactivate('0000')
      expect(trigger).to be_deactivated
    end
  end
end
