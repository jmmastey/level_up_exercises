require 'spec_helper'
require_relative '../bomb'

shared_examples_for 'a typical bomb' do |activation_code, deactivation_code|
  let(:wrong_activation_code) { '9876' }
  let(:wrong_deactivation_code) { '5432' }
  let(:max_tries) { Bomb::MAX_ALLOWED_DEACTIVATION_ATTEMPTS }

  it 'starts deactivated' do
    expect(subject.status).to eq(:deactivated)
    expect(subject).to be_deactivated
  end

  it 'activates with the correct code' do
    expect { subject.activate(activation_code) }.to change { subject.status }.to(:activated)
    expect(subject).to be_activated
  end

  it 'raises exception when activating if the bomb is active' do
    subject.activate(activation_code)
    expect {subject.activate(activation_code)}.to raise_error
  end

  it 'raises exception when activating if the bomb has already exploded' do
    subject.activate(activation_code)
    max_tries.times.each { subject.deactivate(wrong_deactivation_code) }
    expect {subject.activate(activation_code)}.to raise_error
  end

  it 'does not activate with incorrect code' do
    expect { subject.activate(wrong_activation_code) }.not_to change { subject.status }
  end

  it 'deactivates with correct deactivation code if activated' do
    subject.activate(activation_code)
    expect { subject.deactivate(deactivation_code) }.to change { subject.status }.from(:activated).to(:deactivated)
  end

  it 'raises exception when deactivating if the bomb is inactive' do
    expect {subject.deactivate(deactivation_code)}.to raise_error
  end

  it 'raises exception when deactivating if the bomb has already exploded' do
    subject.activate(activation_code)
    (max_tries + 1).times.each { subject.deactivate(wrong_deactivation_code) }
    expect {subject.deactivate(deactivation_code)}.to raise_error
  end

  it 'will explode after too many incorrect deactivation attempts' do
    subject.activate(activation_code)
    max_tries.times.each { subject.deactivate(wrong_deactivation_code) }
    expect { subject.deactivate(wrong_deactivation_code) }.to change { subject.status }.from(:activated).to(:exploded)
    expect(subject).to be_exploded
  end

  it 'has max 3 attempts left after it is activated' do
    subject.activate(activation_code)
    expect(subject.remaining_attempts).to be(3)
  end

  it 'has 2 attempts after a failed deactivation attempts' do
    subject.activate(activation_code)
    subject.deactivate(wrong_deactivation_code)
    expect(subject.remaining_attempts).to be(max_tries - 1)
  end

end

describe Bomb do
  context 'when initialized with default codes' do
    subject { Bomb.new }
    it_should_behave_like "a typical bomb", '1234', '0000'
  end

  context 'when initialized with custom codes' do
    subject { Bomb.new(activation_code: '4321', deactivation_code: '2222') }
    it_should_behave_like "a typical bomb", '4321', '2222'
  end

  context 'when initialized with invalid codes' do
    it 'raises exception with invalid codes' do
      expect { Bomb.new(activation_code: 'John', deactivation_code: 'Doug')}.to raise_error
      expect { Bomb.new(activation_code: "1234", deactivation_code: true)}.to raise_error
      expect { Bomb.new(activation_code: [0544], deactivation_code: '4321')}.to raise_error
    end
  end
end
