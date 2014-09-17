class Wire
  VALID_COLORS = [:red, :green, :blue, :black]

  attr_reader :color

  def initialize(color)
    self.color = color
    @intact = true
  end

  def intact?
    @intact
  end

  def snip
    @intact = false
    self
  end

  def self.get_valid_colors
    VALID_COLORS
  end

  private

  def color=(color)
    raise ArgumentError, "Invalid color." unless VALID_COLORS.include?(color)

    @color = color
  end
end
