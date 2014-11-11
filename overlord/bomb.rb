class Bomb

  attr_reader :active, :exploded
  alias_method :active?, :active
  alias_method :exploded?, :exploded

  AC = 2342
  DC = 0000

  def initialize
    @activation_code = AC
    @deactivation_code = DC
    @failed_attempts = 0
    @active = false
    @exploded = false
  end

  def activate(attempt)
    @active = true if attempt == @activation_code
  end

  def deactivate(attempt)
    if attempt == @deactivation_code
      @active = false
    else
      increment_attempts
    end
  end

  def explode
    @exploded = true
    @active = false
  end

  def increment_attempts
    @failed_attempts += 1
    explode if @failed_attempts >= 3
  end
end

class Detonater

  def initialize(bomb)
    @bomb = bomb
  end

  def trigger(action, argument)
    @bomb.send(action,argument)
  end
end
