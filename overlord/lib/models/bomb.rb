require_relative "wire_bundle"

class Bomb
  attr_accessor :timer, :wires
  attr_reader :error, :failed_deactivations, :max_failed_deact, :state

  def initialize(act_code = "1234", deact_code = "0000", max_failed_deact = 3)
    @state = :inactive
    @act_code = act_code.to_s
    @deact_code = deact_code.to_s
    @max_failed_deact = max_failed_deact
    @wires = WireBundle.new(0, 0)
  end

  def active?
    state == :active
  end

  def disarmed?
    state == :disarmed
  end

  def exploded?
    state == :exploded
  end

  def inactive?
    state == :inactive
  end

  def enter_code(code)
    unless code.nil?
      try_activation(code) if inactive?
      try_deactivation(code) if active?
    end

    self
  end

  def state
    check_wires
    check_timer
    @state
  end

  private

  def activate
    return if active?

    @state = :active
    @error = nil
    @failed_deactivations = 0
  end

  def check_timer
    return unless @state == :active
    explode if timer && timer.expired?
  end

  def check_wires
    return unless wires
    return if [:exploded, :disarmed].include?(@state)

    explode if @state == :active && wires.detonating?
    disarm if wires.disarming?
  end

  def deactivate
    return if @state == :inactive

    @state = :inactive
    @error = nil
  end

  def disarm
    return if @state == :disarmed

    @state = :disarmed
    @error = nil
  end

  def explode
    return if @state == :exploded

    @state = :exploded
    @error = nil
  end

  def try_activation(code)
    return activate if code == @act_code

    @error = :bad_code
  end

  def try_deactivation(code)
    return deactivate if code == @deact_code
    return if code == @act_code

    @error = :bad_code
    @failed_deactivations += 1
    explode if failed_deactivations >= max_failed_deact
  end
end
