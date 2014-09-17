class Wire
  attr_accessor :type
  attr_reader :color

  def initialize(bomb, color)
    @bomb = bomb
    @color = color
    @intact = true
  end

  def intact?
    @intact
  end

  def snip
    @intact = false
    @bomb.send("on_#{type}_wire_snipped") if @type
    self
  end

  private

  def color=(color)
    @color = color
  end
end
