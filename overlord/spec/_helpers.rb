require_relative "../lib/bomb"
require_relative "../lib/wire"
require_relative "../lib/wire_box"

def create_test_wire_box
  disarm_wires = create_disarm_wires
  exploding_wires = create_exploding_wires

  box = WireBox.new(disarm_wires.concat(exploding_wires))
  box.device = Bomb.new

  box
end

private

def create_disarm_wires
  disarm_wires = [
    Wire.new(:red),
    Wire.new(:black)
  ].each { |wire| wire.type = :disarm }

  disarm_wires
end

def create_exploding_wires
  explode_wires = [
    Wire.new(:blue),
    Wire.new(:green)
  ].each { |wire| wire.type = :exploding }

  explode_wires
end
