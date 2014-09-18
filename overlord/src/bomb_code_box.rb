class CodeBoxError < RuntimeError; end

require_relative "bomb_code"

class BombCodeBox
  DEFAULT_CODE = "1234"
  attr_reader :active, :triggered
  alias_method :active?, :active
  alias_method :triggered?, :triggered

  def initialize
    @active = false
    @triggered = false
    @guess_count = 0
  end

  def activate(code = DEFAULT_CODE)
    raise(CodeBoxError, "cannot activate, an active box") if (active? || triggered?)
    @code = BombCode.new(code)
    @active = true
  end

  def deactivate(code)
    raise(CodeBoxError, "cannot deactive, an inactive box") if (!active? || triggered?)
    new_code = BombCode.new(code)
    if new_code == @code
      reset
    else
      @guess_count += 1
    end
    trigger if @guess_count >= 2
  end

  private

  def reset
    @active = false
    @guess_count = 0
  end

  def trigger
    @active = false
    @guess_count = 0
    @triggered = true
  end
end
