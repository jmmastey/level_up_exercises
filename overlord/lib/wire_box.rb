require_relative "wire"

class DisabledError < RuntimeError; end
class ExplodedError < RuntimeError; end
class NoDeviceError < RuntimeError; end

class WireBox
  attr_accessor :device
  attr_reader :wires

  def initialize(wires = [])
    if wires.is_a? Wire
      @wires = [wires]
    else
      @wires = wires
    end
  end

  def check_booby_traps
    device.explode if should_explode
    state
  end

  def disabled?
    state == :disabled
  end

  def disarm_wires
    @wires.select { |wire| wire.is_type?(:disarm) }
  end

  def exploded?
    state == :exploded
  end

  def exploding?
    state == :exploding
  end

  def exploding_wires
    @wires.select { |wire| wire.is_type?(:exploding) }
  end

  def get_wire_from_color(color)
    color = color.to_sym
    @wires.select { |wire| wire.color == color }.first
  end

  def intact?
    state == :intact
  end

  def send_to_device(method, *args)
    raise_disabled_error if disabled?
    raise_exploded_error if exploded?
    raise_no_device_error unless device
    device.send(method, *args)
  end

  def state
    return :exploded if device && device.exploded?
    return :disabled if disarm_wires.all?(&:cut?)
    return :exploding if exploding_wires.any?(&:cut?)
    :intact
  end

  private

  def raise_disabled_error
    raise DisabledError, "Cannot send a message through a disabled wire box."
  end

  def raise_exploded_error
    raise ExplodedError, "Cannot send a message through an exploded box."
  end

  def raise_no_device_error
    raise NoDeviceError, "Wire box is not connected to a device."
  end

  def should_explode
    (state == :exploding) && device && device.intact?
  end
end
