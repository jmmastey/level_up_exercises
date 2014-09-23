class ExplodedError < RuntimeError; end

class Bomb
  attr_reader :state

  def initialize
    @state = :intact
  end

  def explode
    raise ExplodedError, "Bomb has already exploded." if exploded?

    @state = :exploded
  end

  def exploded?
    @state == :exploded
  end

  def intact?
    @state == :intact
  end
end
