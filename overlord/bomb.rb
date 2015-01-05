class Bomb
  attr_accessor :active
  ACTIVATE_CODE = 1234
  DEACTIVATE_CODE = 0000

  def initialize
    self.active = false
  end

  def active?
    active
  end

  def activate(code)
    self.active = true unless code != ACTIVATE_CODE
  end

  private

  def active=(new_active)
    @active = new_active
  end
end