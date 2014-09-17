require_relative "wire"
require_relative "wire_generator"

class Bomb

  attr_reader :activation_code, :deactivation_code, :message,
    :remaining_deactivation_attempts, :wires

  def initialize(activation_code = 1234, deactivation_code = 0000)
    @activation_code = activation_code
    @deactivation_code = deactivation_code
    @state = DEFAULT_STATE
    @wires = []
    @message = "Booted"
    reset_remaining_deactivation_attempts
  end

  def active?
    @state == :active
  end

  def enter_code(code)
    return unless STATE_CONTEXT_MAP.include?(@state)

    send(STATE_CONTEXT_MAP[@state], code)
  end

  def exploded?
    @state == :exploded
  end

  def inactive?
    @state == :inactive
  end

  def init_wires
    generator = WireGenerator.new
    wires = generator.generate_wires(self)
  end

  def on_disarming_wire_snipped
    if active?
    end

  end

  def on_exploding_wire_snipped

  end

  private

  DEFAULT_STATE = :inactive
  STATE_CONTEXT_MAP = {
    active: :enter_code_when_active,
    inactive: :enter_code_when_inactive
  };

  def activate
    return if exploded?

    @state = :active
    @message = "Activated"
  end

  def deactivate
    return if exploded?

    @state = :inactive
    @message = "Deactivated"
  end

  def reset_remaining_deactivation_attempts
    @remaining_deactivation_attempts = 3
  end

  def use_deactivation_attempt
    @remaining_deactivation_attempts -= 1
  end

  def enter_code_when_active(code)
    return deactivate if code == @deactivation_code
    use_deactivation_attempt unless code == @activation_code && ignore_activation_code?
    report_invalid_code
  end

  def enter_code_when_inactive(code)
    return activate if code == @activation_code
    report_invalid_code
  end

  def explode
    return unless active?

    @state = :exploded
    @message = "Boom"
  end

  def ignore_activation_code?
    @remaining_deactivation_attempts == 3
  end

  def report_invalid_code
    @message = "Invalid Code"
  end

  def wire_status
    return :normal unless wires.any?
    return :explode unless all_exploding_wires_intact?
    return :disarm if all_disarm_wires_cut?

    :normal
  end

  def all_disarm_wires_cut?
    disarm_wires = wires.select { | wire| wire.type == :disarming }
    wires.none?(&:intact?)
  end

  def all_exploding_wires_intact?
    exploding_wires = wires.select { |wire| wire.type == :exploding }
    wires.all?(&:intact?)
  end

end
