class Bomb
  attr_accessor :codes, :seqs, :armed, :hacked

  def initialize
    @codes = (1...64).to_a.sample(6)
    @seqs = [[],[],[],[],[],[]].map{|_| [0] * 6 }
    @hacked = [false] * 6
    @armed = false

    @secret_code = 8005882300
  end

  def hacked?(panel_num)
    @hacked[panel_num]
  end

  def all_hacked?
    (0..5).all? do |panel_num|
      @hacked[panel_num]
    end
  end

  def panel_input(panel_num, button_num)
    @seqs[panel_num][button_num]
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
    @hacked[panel_num] = match
  end

  def enter_code(code)
    same = (code == @secret_code)
    @armed = !(@armed && same) if same
  end

  def armed?
    @armed
  end
end