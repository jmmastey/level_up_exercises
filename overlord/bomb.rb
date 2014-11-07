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
    @active = true if attempt == ACTIVATION
  end

  def deactivate(attempt)
    if attempt == DEACTIVATION
       @active = false
     else
    @failed_attempts += 1
    blah
 end
end

#   private
#   def success
#     @attempt == DEACTIVATION
#   end

def blah
  if @failed_attempts == 3
      @exploded = true
      @active = false
   end
end
#   def exploded
#     @exploded = true if @failed_attempts == 3
#   end

#   def failure
#     @attempt < 3
#   end
# end