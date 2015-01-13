class Bomb
  attr_accessor :active, :detonated, :invalid_count

  def initialize(attributes = {})
    @active = attributes.fetch(:active, false)
    @invalid_count = attributes.fetch(:invalid_count, 0)
    @detonated = attributes.fetch(:detonated, false)
  end

  def active?
    active
  end

  def detonated?
    detonated
  end

  def process_code(code)
    if active?
      deactivate(code)
    else
      activate(code)
    end
  end

  def activate(code)
    @active = true if code == ACTIVATE_CODE
  end

  def deactivate(code)
    if code == DEACTIVATE_CODE
      deactivate_confirm
    else
      deactivate_deny
    end
  end

  private

  ACTIVATE_CODE = "1234"
  DEACTIVATE_CODE = "0000"
  MAX_INVALID = 3

  def deactivate_confirm
    @active = false
    @invalid_count = 0
  end

  def deactivate_deny
    @invalid_count = invalid_count + 1
    detonate if invalid_count == MAX_INVALID
  end

  def detonate
    @detonated = true
  end
end
