require 'spec_helper'
require_relative '../observation'

describe Observation do
  let(:success_observation) { Observation.new("A", true) }
  let(:failure_observation) { Observation.new("A", false) }

  it 'initializes correctly' do
    expect(success_observation.subject).to eq("A")
    expect(success_observation.success).to be true
    expect(failure_observation.subject).to eq("A")
    expect(failure_observation.success).to be false
  end
end
