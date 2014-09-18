class Wire
  attr_accessor :type
  attr_reader :color

  def initialize(color)
    @color = color
    @state = :intact
  end

  def cut?
    @state == :cut
  end

  def intact?
    @state == :intact
  end

  def is_type?(type)
    @type == type
  end

  def snip
    raise RuntimeError, "Wire is already cut." if cut?

    @state = :cut
  end
end
