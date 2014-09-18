def get_test_wire_box
  disarm_wires = [
    Wire.new(:red),
    Wire.new(:black)
  ].each { |wire| wire.type = :disarm }
  explode_wires = [
    Wire.new(:blue),
    Wire.new(:green)
  ].each { |wire| wire.type = :exploding }

  box = WireBox.new(disarm_wires.concat(explode_wires))
  box.device = Bomb.new

  box
end
