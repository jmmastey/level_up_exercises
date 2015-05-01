require 'rufus-scheduler'

BOMB_DURATION = 30

class Bomb

  attr_reader :time_remaining
  attr_reader :exploded

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
    return code if code =~ /^\d{4}$/
    return default if code == ""
    return nil
  end 

  def start_bomb(activation_code)
    if @activation_code == activation_code
      @active = true
      @scheduler.every('1s') do
        @time_remaining -= 1
        @exploded = true if @time_remaining <= 0.0
      end
      @scheduler.every '0.3s' do
        explode_bomb if @exploded
      end
  end

  def attempt_deactivation(deactivation_code)
    return 'Bomb already exploded' if @exploded
    if @deactivation_code == deactivation_code and @num_deactivation_attempts > 0
      @active = false
    else
      @num_deactivation_attempts -= 1
      @exploded = true if @num_deactivation_attempts <= 0
    end
  end

  def explode_bomb
    return 'Bomb exploded' if @exploded
  end

  def reset_bomb
    @time_remaining = BOMB_DURATION
    @scheduler = Rufus::Scheduler.new    
    @active = false
    @exploded = false
  end
    
      
      
    



end
