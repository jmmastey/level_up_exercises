class BombStateError < RuntimeError; end

require_relative "bomb_code"

class Bomb
  DEFAULT_CODE = "1234"
  attr_reader :active, :blown_up
  alias_method :active?, :active
  alias_method :blown_up?, :blown_up

  def initialize
    @active = false
    @blown_up = false
    @guess_count = 0
  end

  def activate(code = DEFAULT_CODE)
    raise(BombStateError, "cannot activate") if (active? || blown_up?)
    @code = BombCode.new(code)
    @active = true
  end

  def deactivate(code)
    raise(BombStateError, "cannot deactive") if (!active? || blown_up?)
    new_code = BombCode.new(code)
    if new_code == @code
      @active = false
    else
      @guess_count += 1
    end
    blow_up if @guess_count >= 2
  end

  private

  def blow_up
    @active = false
    @blown_up = true
    @guess_count = 0
  end
end
