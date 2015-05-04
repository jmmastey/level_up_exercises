BombCodeError = Class.new(RuntimeError)

require 'rufus-scheduler'

BOMB_DURATION = 30

class Bomb

  attr_reader :time_remaining
  attr_reader :exploded
  attr_reader :active 

  def initialize(activation_code, deactivation_code)
    @activation_code = set_code(activation_code, 1234)
    @deactivation_code = set_code(deactivation_code, 0000)
    @time_remaining = BOMB_DURATION # seconds
    @active = false
    @exploded = false
    @num_deactivation_attempts = 3
    @scheduler = Rufus::Scheduler.new
  end

  def set_code(code, default)
    return code if code.to_s =~ /^\d{4}$/
    return default if code == ""
    raise BombCodeError, "Your code, #{code}, is invalid. Choose a 4 digit code."
  end 

  def start_bomb(activation_code)
    if @activation_code == activation_code
      @active = true
      schedule_bomb_timer
    end
  end

  def schedule_bomb_timer
    @scheduler.every('1s') do 
      @time_remaining -= 1
      explode_bomb if @time_remaining == 0
    end
  end

  def attempt_deactivation(deactivation_code)
    return 'Bomb already exploded.' if @exploded
    return 'Bomb is not currently active.' if not @active
    if @deactivation_code == deactivation_code and @num_deactivation_attempts > 0
      @active = false
      @scheduler.pause
    else
      @num_deactivation_attempts -= 1
      explode_bomb if @num_deactivation_attempts <= 0
    end
  end

  def restart_bomb(activation_code)
    return "Can't restart because bomb never activated." if not @scheduler.paused?
    @active = true
    @scheduler.resume
  end

  def explode_bomb
    @exploded = true
    @active = false
    @scheduler.pause
    puts 'Bomb exploded'
  end
end
