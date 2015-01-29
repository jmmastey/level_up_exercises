# This custom matcher can be used to test an event for a state machine
#
# Examples
#
#   When using is_expected.to be sure to set a subject
#   it { is_expected.to allow_event(:status, :event_name, :status (initial status)) }

RSpec::Matchers.define :allow_event do |state_field, event_to, status|
  match do |model|
    model.send("#{state_field}=", status) #set initial status
    model.send("#{event_to}") #trigger status change, returns true or false.
  end

  failure_message do |model|
    "expected to allow event #{event_to} to fire"
  end

  failure_message_when_negated do |model|
    "expected to not allow even #{event_to} to fire"
  end

  description do
    "call event #{event_to} on the #{state_field} field from #{status}"
  end
end
