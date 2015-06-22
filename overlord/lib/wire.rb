class Wire
  attr_reader :intact, :type

  def initialize(type)
    @intact = true
    @type = type.to_sym
  end

  def cut
    return false unless @intact

    @intact = false
    true
  end

  def disarming?
    @type == :disarm
  end

  def detonating?
    @type == :detonating
  end

  def intact?
    intact
  end
end
