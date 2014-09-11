require 'pry'
StateMachineException = Class.new(Exception)

class State

  attr_accessor :name, :state

  def initialize(name)
    @name = name.to_s.downcase
    @state = state_for(name)
  end
  
  def eql?(other_state)
    @name == other_state.name
  end

  def transition_to!(to_state)
    @name = to_state.name
    @state = to_state.state
  end

  def state_for(to)
    case to
    when StateMachine.dormant
      {armed_at: nil, activation_code: nil, deactivation_code: nil}
    when StateMachine.active
      {armed_at: Time.now, retries: 3, timer: "30"}
    when StateMachine.blown
      {armed_at: nil, activation_code: nil, deactivation_code: nil}
    end
  end

  def update!
    if @name.eql? StateMachine.active
    	@state[:retries] -= 1
    end
    @state[:retries] && @state[:retries] <= 0
  end
end
