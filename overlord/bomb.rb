class Bomb
  attr_accessor :state_table, :count

  NUMBER_OF_TRIES = 3
  def initialize
    @state_table = { booted: false, activated: false,
                     deactivated: false, exploded: false }
    @a_code_correct = nil
    @d_code_correct = nil
    @count = 0
  end

  def booted(_code)
    # if (code.nil?) || (number? (code))
    @state_table[:booted] = true
    # end
  end

  def activated(correct_code, d_code, input)
    @a_code_correct = correct_code.length < 1 ? "1234" : correct_code
    @d_code_correct = d_code.length < 1 ? "0000" : d_code
    return unless @a_code_correct == input
    @state_table[:activated] = true
  end

  def check_exploded
    return unless @count == 3
    @state_table[:exploded] = true
  end

  def deactivate(input)
    if @d_code_correct == input
      @state_table[:deactivated] = true
    else
      @count += 1
      check_exploded
    end
  end

  def status(params)
    @state_table[params]
  end

  def number?(string)
    true if Float(string) rescue false
  end
end
