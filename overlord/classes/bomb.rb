require './classes/panel.rb'

class Bomb
  STATES = { 0 => 'armed', 1 => 'disarmed', 2 => 'detonated', 3 => 'hacked' }

  attr_accessor :state, :start_time, :panels
  attr_accessor :hack_count, :attempts_remain

  def initialize
    codes = (1...64).to_a.sample(6)
    @panels = codes.map { |code| Panel.new(code) }

    @hack_count = 0
    @attempts_remain = 3

    @state = 1
  end

  def secret_codes(code_hash)
    @secret_arm_code = code_hash[:arm]
    @secret_disarm_code = code_hash[:disarm]
  end

  def codes_set?
    !!@secret_arm_code && !!@secret_disarm_code
  end

  def hacked?(panel_num)
    @panels[panel_num].hacked?
  end

  def sequence_for(panel_num)
    @panels[panel_num].sequence
  end

  def attempt_hack(binary, panel_num)
    match = @panels[panel_num].validate(binary)
    if match
      @hack_count += 1
      @state = 3 if @hack_count == 6
    end
    @panels[panel_num].hacked = match
  end

  def check_code(code, stored_code, state_if_same)
    if code != stored_code
      @attempts_remain -= 1
      @state = 2 if @attempts_remain == 0
    else
      @state = state_if_same
    end
  end

  def arm(code)
    return false if @state > 1

    check_code(code, @secret_arm_code, 0)
    code == @secret_arm_code
  end

  def disarm(code)
    return false if @state > 1

    check_code(code, @secret_disarm_code, 1)
    code == @secret_disarm_code
  end

  def state_to_s
    STATES[@state]
  end

  def armed?
    @state == 0
  end
end
