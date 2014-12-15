require 'pry'
class Bomb
  attr_accessor :activate_code, :deactivation_code, :attempts,
                :exploded, :active, :start_timer, :message

  COUNTDOWN_SECONDS = 30
  ACTIVATION_CODE = '1234'
  DEACTIVATION_CODE = '0000'

  def initialize(activecode, deactivecode)
    @activate_code = verify_set_code('activation', activecode)
    @deactivation_code = verify_set_code('deactivation', deactivecode)
    @attempts = 0
    @exploded = false
    @active = false
  end

  def activate?(code)
    @active = (code == @activate_code) && !@exploded
  end

  def deactivate(stop_code)
    if (stop_code != @deactivation_code) && !@exploded
      deactivate_attempts
    else
      @active = false
    end
  end

  def deactivate_attempts
    @attempts += 1
    return if @attempts < 3
    @exploded = true
    @message = 'You have exceeded 3 attempts - BOMB exploded!!!'
  end

  def start_time
    @start_timer = (Time.now).to_i
    @message = "You have #{COUNTDOWN_SECONDS} seconds and 3 attempts, to enter the right deactivation code."
  end

  def elapsed_time
    (Time.now).to_i - @start_timer
  end

  def check_time
    return if @exploded
    if elapsed_time > COUNTDOWN_SECONDS
      @message = 'Your time has expired - BOMB exploded!!!'
      @exploded = true
    else
      time_left = (COUNTDOWN_SECONDS - elapsed_time).to_i
      attempts_left = 3 - @attempts
      @message = "You have #{time_left} seconds and #{attempts_left} attempts, to enter the right deactivation code."
    end
  end

  private

  def verify_set_code(code_type, code)
    fail ArgumentError if !code.empty? && !(code =~ /^\d+$/)
    if code_type == 'activation' && code.empty?
      code = ACTIVATION_CODE
    elsif code_type == 'deactivation' && code.empty?
      code = DEACTIVATION_CODE
    end
    code
  end
end
