class Wire
  attr_reader :type

  def initialize(type)
    @intact = true
    @type = type.to_sym
  end

  def cut
    @intact = false
    self
  end

  def disarming?
    @type == :disarm
  end

  def detonating?
    @type == :detonating
  end

  def intact?
    @intact
  end
end
