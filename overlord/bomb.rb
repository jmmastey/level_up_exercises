class Bomb
  attr_accessor :detonated
  attr_reader :active

  def initialize
    @active = false
    @invalid_count = 0
  end

  def active?
    active
  end

  def detonated?
    detonated
  end

  def activate(code)
    @active = true unless code != ACTIVATE_CODE
  end

  def deactivate(code)
    if code == DEACTIVATE_CODE
      deactivate_confirm
    else
      deactivate_deny
    end
  end

  private

  attr_accessor :invalid_count
  ACTIVATE_CODE = 1234
  DEACTIVATE_CODE = 0000
  MAX_INVALID = 3

  def deactivate_confirm
    @active = false
    @invalid_count = 0
  end

  def deactivate_deny
    invalid_count++
    self.detonate if invalid_count == MAX_INVALID
  end

  def detonated=(new_detonated)
    @detonated = new_detonated
  end

  def detonate
    self.detonated = true
  end
end