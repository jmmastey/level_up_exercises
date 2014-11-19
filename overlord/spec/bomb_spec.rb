require 'spec_helper'
require_relative '../bomb'

shared_examples_for 'a typical bomb' do |activation_code, deactivation_code|
  let(:wrong_activation_code) { '7654' }
  let(:wrong_deactivation_code) { '9999' }
  let(:max_tries) { Bomb::MAX_ALLOWED_DEACTIVATION_ATTEMPS }

  it 'is in deactivated status after the initilaization' do
    expect(subject.status).to eq(:deactivated)
    expect(subject).to be_deactivated
  end

  it 'can be activated with default activation code' do
    expect { subject.activate(activation_code) }.to change { subject.status }.to(:activated)
    expect(subject).to be_activated
  end

  it 'cannot be activated with wrong activation code' do
    expect { subject.activate(wrong_activation_code) }.not_to change { subject.status }
  end

  it 'can be deactivated with default deactivation code once activated' do
    subject.activate(activation_code)
    expect { subject.deactivate(deactivation_code) }.to change { subject.status }.from(:activated).to(:deactivated)
  end

  it 'will explode if tried to deactivate after maximum allowed number of tries' do
    subject.activate(activation_code)
    max_tries.times.each { subject.deactivate(wrong_deactivation_code) }
    expect { subject.deactivate(wrong_deactivation_code) }.to change { subject.status }.from(:activated).to(:exploded)
    expect(subject).to be_exploded
  end

  it 'has max tries attempts after it is activated' do
    subject.activate(activation_code)
    expect(subject.remaining_attempts).to be(max_tries)
  end

  it 'has (max tries - 2) attempts after two failed deactivation attempts' do
    subject.activate(activation_code)
    2.times.each { subject.deactivate(wrong_deactivation_code) }
    expect(subject.remaining_attempts).to be(max_tries - 2)
  end
end

describe Bomb do
  context 'when initialized with default codes' do
    subject { Bomb.new }
    it_should_behave_like "a typical bomb", '1234', '0000'
  end

  context 'when initialized with custom codes' do
    subject { Bomb.new(activation_code: '7755', deactivation_code: '2323') }
    it_should_behave_like "a typical bomb", '7755', '2323'
  end
end
