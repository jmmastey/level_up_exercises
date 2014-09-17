
class WireBox
  def initialize(params)
    @wire_colors = params[:wire_colors]
    @safe_wire = params[:safe_wire]
    @triggered = false
  end
  def snip(color)
    raise(RuntimeError, "you must snip a wire a color #{@wire_colors}") unless @wire_colors.include?(color)
    @triggered = true unless color == @safe_wire
  end

  def triggered?
    @triggered
  end
end
