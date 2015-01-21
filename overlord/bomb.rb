class Bomb
  def initialize(params)
    @activation_code ||= 1234
    @deactivation_code ||= 0000
    @attempts_remaining = 3
  end

  def active?

  end

  def exploded?
    
  end

end