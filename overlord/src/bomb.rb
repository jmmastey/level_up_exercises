class Bomb
  attr_reader :exploded
  method_alias :exploded?, :exploded

  def initialize
    @exploded = false
  end

  def explode
    @exploded = true
  end
end
