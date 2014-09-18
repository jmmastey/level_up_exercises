require_relative "wire"

class WireGenerator
  DISARM_TO_EXPLODING_RATIO = 0.4

  def initialize
    @valid_wire_colors = read_valid_wire_colors
  end

  def generate_wires(number_of_wires = generate_random_wire_count)
    colors = @valid_wire_colors.sample(number_of_wires)
    wires = colors.map { |color| Wire.new(color) }
    configure_wires(wires)
  end

  private

  def configure_wires(wires)
    num_of_disarming_wires = generate_number_of_disarming_wires(wires.count)
    wires.shuffle!
    disarm_wires, explode_wires = split_array(wires, num_of_disarming_wires)
    configure_disarm_wires(disarm_wires)
    configure_exploding_wires(explode_wires)
    wires.shuffle!
  end

  def configure_disarm_wires(wires)
    wires.each { |wire| wire.type = :disarming }
  end

  def configure_exploding_wires(wires)
    wires.each { |wire| wire.type = :exploding }
  end

  def generate_number_of_disarming_wires(wire_count)
    max = (wire_count * DISARM_TO_EXPLODING_RATIO).ceil
    rand(max) + 1
  end

  def generate_random_wire_count
    (3..6).to_a.sample
  end

  def read_valid_wire_colors
    file = File.read("./valid_wire_colors.dat")
    file.split("\n").map(&:to_sym)
  end

  def split_array(array, count)
    [
      array.slice(0, count),
      array.slice(count, array.count - count) || []
    ]
  end
end
