# This custom matcher can be used to test existence of events in a state machine
#
# Examples
#
#   it { is_expected.to have_event(:status, :event_name, [ :state1 => state2 ]) }
#   it { is_expected.to have_event(:status, :event_name, [ :state1, state2 ] => [ state3, state4 ]) }
#   it { is_expected.to have_event(:status, :event_name, { :state1 => state2, state1 => state3, :state4 => state5 etc })}

require 'ostruct'

RSpec::Matchers.define :have_event do |state_field, event_name, status_flows|
  match do |model|
    all_transitions = []

    status_flows.each do |from, to|
      from_arr = *from
      to_arr = *to
      from_arr.product(to_arr).each do |from, to|
        all_transitions << OpenStruct({ :from => from, :to => to })
      end
    end

    events = model.class.state_machines[state_field].events
    event = events[event_name]

    @unexpected_transitions = all_transitions.select do |transition|
      !events.valid_for(model, :from => transition.from, :to => transition.to).include?(event)
    end

    @unexpected_transitions.empty?
  end

  failure_message do
    unexpected_transitions_str = @unexpected_transitions.map do |t|
      "#{event_name}: :#{t.from} => :#{t.to}"
    end.join(', ')
    "there are unexpected transitions in the expectation: [#{unexpected_transitions_str}]"
  end

  description do
    "have #{event_name} event for #{state_field} with transitions #{status_flows}"
  end

  def OpenStruct(params)
    params.is_a?(OpenStruct) ? params : OpenStruct.new(params)
  end
end
