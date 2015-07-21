require 'models/trigger'

RSpec.describe Trigger do
  context 'default configuration' do
    let(:trigger) { Trigger.new }

    it 'will not be active' do
      expect(trigger).to be_deactivated
    end

    it 'will have a default activation code' do
      expect(trigger.activation_code).to eq('1234')
    end

    it 'will have a default deactivation code' do
      expect(trigger.deactivation_code).to eq('0000')
    end
  end

  context 'custom configuration' do
    let(:trigger) { Trigger.new(activate: '9292', deactivate: '1138') }

    it 'accepts a custom activation code' do
      expect(trigger.activation_code).to eq('9292')
    end

    it 'accepts a custom deactivation code' do
      expect(trigger.deactivation_code).to eq('1138')
    end
  end

  context 'activation' do
    let(:trigger) { Trigger.new }

    it 'requires a correct activation code' do
      trigger.activate('1234')
      expect(trigger).to be_activated
    end
  end

  context 'deactivation' do
    let(:trigger) { Trigger.new }

    it 'requires a correct deactivation code' do
      trigger.deactivate('0000')
      expect(trigger).to be_deactivated
    end
  end
end
