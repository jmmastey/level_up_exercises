class Transitionable
  attr_accessor :from_status, to_state

  def initialize(from_status, to_state)
    @from_status = from_status
    @to_state = to_state
  end

  def status_eql?(other_transitionable)
    @from_status[:retries] >= other_transitionable.status[:retries]
    @from_status[:time_runs_out] <= other_transitionable.status[:time_runs_out]
  end

  def state_eql?(other_transitionable)
    @to_state.eql?(other_transitionable.to_state)
  end

end
