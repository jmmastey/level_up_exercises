require_relative "wire"

class WireBundle
  attr_reader :wires

  def initialize(disarming_wire_count, detonating_wire_count)
    @wires = (1..disarming_wire_count).map { Wire.new(:disarm) }
    detonating_wires = (1..detonating_wire_count).map { Wire.new(:detonating) }
    @wires.concat(detonating_wires)
  end

  def disarming?
    disarming_wires.any? && disarming_wires.none?(&:intact?)
  end

  def detonating?
    detonating_wires.any? && !detonating_wires.all?(&:intact?)
  end

  def disarming_wires
    wires.select(&:disarming?)
  end

  def detonating_wires
    wires.select(&:detonating?)
  end
end
