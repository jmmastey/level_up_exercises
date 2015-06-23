require_relative "wire_bundle"

class Bomb
  MAX_FAILED_DEACTIVATIONS = 3

  attr_accessor :timer, :wires
  attr_reader :error, :failed_deactivations

  def initialize(activation_code, deactivation_code)
    @state = :inactive
    @activation_code = activation_code.to_s
    @deactivation_code = deactivation_code.to_s
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
    @state = :inactive
    @error = nil
  end

  def disarm
    @state = :disarmed
    @error = nil
  end

  def explode
    @state = :exploded
    @error = nil
  end

  def try_activation(code)
    return activate if code == @activation_code

    @error = :bad_code
  end

  def try_deactivation(code)
    return deactivate if code == @deactivation_code
    return if code == @activation_code

    @error = :bad_code
    @failed_deactivations += 1
    explode if failed_deactivations >= MAX_FAILED_DEACTIVATIONS
  end
end
