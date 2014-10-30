class Bomb

  attr_reader :active, :exploded

  alias_method :active?, :active
  alias_method :exploded?, :exploded

  def initialize(act_code = 2342, deact_code = 0000)
    @deactivation_code = deact_code
    @activation_code  = act_code
    @failed_attempts = 0

    @active = false
    @exploded = false
  end

  def enter_code(guess)
    @guess = guess
  end

  def activate
    @active = true if @guess == @activation_code  && !@exploded
  end

  def deactivate
    if @guess == @deactivation_code && !@exploded
       @active = false
    else
      @failed_attempts += 1
      if @failed_attempts == 3
         @exploded = true
         @active = false
      elsif @failed_attempts == 1
        @active = true
      end
    end
  end
end
