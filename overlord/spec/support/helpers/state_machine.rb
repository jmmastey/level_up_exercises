module Helpers
  module StateMachine
    def get_states(object)
      raise "The #{object.class} has no state machine!" unless object.respond_to?(:state_machine)
      object.state_machine.states.map(&:name)
    end
  end
end
