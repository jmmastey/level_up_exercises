require_relative "wire"

class WireBox
  def initialize(params)
    @wires = params[:wire_colors].map { |color| Wire.new(color) }
    @safe_wire = @wires.find { |wire| wire.color ==  params[:safe_color] }
    raise(RuntimeError, "there is no wire which matches the safe color") if @safe_wire.nil?
    @triggered = false
  end

  def snip(color)
    wire = @wires.find { |w| w.color == color }
    raise(RuntimeError, "there is no wire of color '#{color}'") if wire.nil?
    wire.snip
    @triggered = true unless wire == @safe_wire
  end

  def triggered?
    @triggered
  end

  def wires
    @wires
  end
end
