class Bomb

  attr_reader :active, :exploded

  alias_method :active?, :active
  alias_method :exploded?, :exploded
  ACTIVATION = 2342
  DEACTIVATION = 0000

  def initialize
    @failed_attempts = 0
    @active = false
    @exploded = false
  end

  def activate(attempt)
    @active = true if attempt == ACTIVATION && !@exploded
  end

  def deactivate(attempt)
   if attempt  == DEACTIVATION && !@exploded
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
