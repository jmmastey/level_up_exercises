require 'pry'
require_relative 'bomb_rules'

module StateMachine

  STATES = {dormant: "/", active: "/activated", blown: "/boom"}
  STATES.each do |state, path|
    self.define_singleton_method(state) do
      state.to_s
    end
  end

  DEPENDENCY_GRAPH = {}
  DEPENDENCY_GRAPH.merge!({dormant() => active()})
  DEPENDENCY_GRAPH.merge!({active() => [blown(), dormant()]})
  DEPENDENCY_GRAPH.merge!({blown() => dormant()})

  def transitionable?(from_state, to)
    case to
    when StateMachine.dormant
      BombRules.is_or_can_deactivate? from_state
    when StateMachine.active
      BombRules.is_or_can_activate? from_state
    when StateMachine.blown
      BombRules.is_or_can_explode? from_state
    end
  end

  def transition(from_state, to)
    return [nil, false, false] if from_state.name.eql? to
    return [nil, false, true] unless descendants(from_state).include? to

    transitionable = transitionable? from_state, to
    pre_transition_from_state = Marshal.load(Marshal.dump(from_state))

    if transitionable
    	perform_transition!(from_state, to)
    else
    	transitionable = from_state.update!
      default_transition!(from_state) if transitionable
    end
    transition_notice = transition_notice(pre_transition_from_state, State.new(to), transitionable)
    [transition_notice, transitionable, true]
  end


  def default_transition!(from_state)
    to = descendants_ready_for_transition(from_state)
    raise StateMachineException, "Multiple transitionable states" if to.size > 1

    perform_transition!(from_state, to.first)
  end

  def perform_transition!(from_state, to)
    unless to.nil? or to.empty?
      from_state.transition_to! State.new(to)
    end
  end

  def descendants_ready_for_transition(from_state)
    (Array(descendants(from_state)).map { |descendant| descendant if transitionable?(from_state, descendant) }).compact
  end

  def descendants(from_state)
    DEPENDENCY_GRAPH[from_state.name]
  end
  
  def transition_notice(from_state, to_state, result)
    if from_state.name.eql?(StateMachine.active) && result.eql?(false)
    	"Nope, nope, nope, nope. You have #{from_state.state[:retries] - 1} retries left"
    elsif from_state.name.eql?(StateMachine.active) && to_state.name.eql?(StateMachine.dormant) && result.eql?(true)
      "Bomb successfully deactivated"
    else
    	nil
    end
  end

end
