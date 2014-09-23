class Max
  attr_reader :value

  def initialize(value = nil)
    @value = value
  end

  def update(x)
    @value ||= x
    @value = x if x > @value
  end

  def <<(x)
    update(x)
  end
end

class Min
  attr_reader :value

  def initialize(value = nil)
    @value = value
  end

  def update(x)
    @value ||= x
    @value = x if x < @value
  end

  def <<(x)
    update(x)
  end
end
