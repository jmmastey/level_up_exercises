class Bomb
  attr_accessor :codes, :state, :states
  attr_accessor :hacked, :hack_count, :attempts_remain

  def initialize
    @codes = (1...64).to_a.sample(6)
    @hacked = [false] * 6
    @hack_count = 0

    @attempts_remain = 3
    @states = {0 => 'armed', 1 => 'disarmed', 2 => 'detonated', 3 => 'hacked'}
    @state = 1
  end

  def set_codes(code_hash)
    @secret_arm_code = code_hash[:arm]
    @secret_disarm_code = code_hash[:disarm]
  end

  def hacked?(panel_num)
    @hacked[panel_num]
  end

  def sequence_for(panel_num)
    code = @codes[panel_num]
    (0..5).to_a.reverse.map do |idx|
      pow = 2**idx
      if pow <= code
        code -= pow
        1
      else
        0
      end
    end
  end

  def validate(binary, decimal)
    sum = binary.reverse
      .each_with_index
      .map { |bin, idx| bin * (2**idx) }
      .inject(&:+)

    sum == decimal
  end

  def attempt_hack(binary, panel_num)
    match = validate(binary, @codes[panel_num])
    if(@hacked[panel_num] = match)
      @hack_count += 1
      @state = 3 if @hack_count == 6
      true
    else
      false
    end
  end

  def arm(code)
    return false if @state > 1

    if code != @secret_arm_code
      @attempts_remain -= 1
      @state = 2 if @attempts_remain == 0
      false
    else
      @state = 0
      true
    end
  end

  def disarm(code)
    return false if @state > 1

    if code != @secret_disarm_code
      @attempts_remain -= 1
      @state = 2 if @attempts_remain == 0
      false
    else
      @state = 1
      true
    end
  end

  def state_to_s
    @states[@state]
  end

  def armed?
    @state == 0
  end
end