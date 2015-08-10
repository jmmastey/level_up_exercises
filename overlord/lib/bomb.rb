require 'sinatra/base'
require 'singleton'

class Bomb
  include Singleton
  DEFAULT_ARMING_CODE = '0000'
  DEFAULT_DISARMING_CODE = '1234'
  MAX_ATTEMPTS = 3

  attr_accessor :arming_code,
    :disarming_code,
    :status,
    :disarming_count

  def initialize
    @status = 'Not Booted'
    @disarming_count = 0
  end

  def not_booted?
    status == 'Not Booted'
  end

  def booted?
    status == 'Booted'
  end

  def armed?
    status == 'Armed'
  end

  def disarmed?
    status == 'Disarmed'
  end

  def detonated?
    status == 'Detonated'
  end

  def boot_bomb
    @status = 'Booted'
    @arming_code = DEFAULT_ARMING_CODE
    @disarming_code = DEFAULT_DISARMING_CODE
  end

  def shutdown
    @disarming_count = 0
    @status = 'Not Booted'
    @arming_code = DEFAULT_ARMING_CODE
    @disarming_code = DEFAULT_DISARMING_CODE
  end

  def attempts_remaining
    MAX_ATTEMPTS - disarming_count
  end

  def track_count
    @disarming_count += 1
    @status = "Detonated" if disarming_count == MAX_ATTEMPTS
  end

  def configure_arming_code(code = nil)
    @arming_code = code unless blank?(code)
  end

  def configure_disarming_code(code = nil)
    @disarming_code = code unless blank?(code)
  end

  def arm(code)
    @status = "Armed"  if code == arming_code
  end

  def disarm(code)
    if code == disarming_code
      @status = "Disarmed"
      @disarming_count = 0
    else
      track_count
    end
  end

  def blank?(str)
    str.nil? || str == '' || str == []
  end
end
