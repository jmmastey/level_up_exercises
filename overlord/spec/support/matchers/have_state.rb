# This custom matcher can be used to test an event for a state machine
#
# Examples
#
#   When using is_expected.to be sure to set a subject
#   it { is_expected.to have_state(:status, :state) }

RSpec::Matchers.define :have_state do |state|
  match do |model|
    model.state_machine.states.map(&:name).include? state
  end

  failure_message do |model|
    "expected to have state #{state}"
  end

  failure_message_when_negated do |model|
    "expected to not have state = #{state}"
  end

  description do
    "have state = #{state}"
  end
end
