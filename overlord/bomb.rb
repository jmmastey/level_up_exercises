require './bomb_error'

class Bomb
  attr_accessor :active, :detonated, :invalid_count, :activate_code, :deactivate_code, :configured
  DEFAULT_ACTIVATE_CODE = "1234"
  DEFAULT_DEACTIVATE_CODE = "0000"
  MAX_INVALID = 3

  def initialize(attributes = {})
    @active = attributes.fetch(:active, false)
    @invalid_count = attributes.fetch(:invalid_count, 0)
    @detonated = attributes.fetch(:detonated, false)
  end

  def activate_code
    @activate_code ||= DEFAULT_ACTIVATE_CODE
  end

  def activate_code=(new_activate_code)
    if self.code_is_valid?(new_activate_code)
      @activate_code = new_activate_code
    else
      raise BombError, "Invalid activation code"
    end
  end

  def deactivate_code
    @activate_code ||= DEFAULT_DEACTIVATE_CODE
  end

  def deactivate_code=(new_deactivate_code)
    if self.code_is_valid?(new_deactivate_code)
      @deactivate_code = new_deactivate_code
    else
      raise BombError, "Invalid deactivation code"
    end
  end

  def configured
    @configured ||= false
  end

  def configured?
    configured
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
    @active = true if code == activate_code
  end

  def deactivate(code)
    if code == deactivate_code
      deactivate_confirm
    else
      deactivate_deny
    end
  end

  def self.code_is_valid?(code)
    (code =~ /\A[0-9]+\Z/) == 0
  end

  private

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
