
class Wire
  attr_reader :color
  def initialize(color)
    @color = color
    @snipped = false
  end

  def snip
    @snipped = true
  end

  def snipped?
    @snipped
  end
end
