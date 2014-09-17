class CodeBoxError < RuntimeError; end

require_relative "bomb_code"

class BombCodeBox
  DEFAULT_CODE = "1234"
  attr_reader :active, :fired
  alias_method :active?, :active
  alias_method :fired?, :fired

  def initialize
    @active = false
    @fired = false
    @fire_handlers = []
    @guess_count = 0
  end

  def activate(code = DEFAULT_CODE)
    raise(CodeBoxError, "cannot activate, an active box") if (active? || fired?)
    @code = BombCode.new(code)
    @active = true
  end

  def deactivate(code)
    raise(CodeBoxError, "cannot deactive, an inactive box") if (!active? || fired?)
    new_code = BombCode.new(code)
    if new_code == @code
      reset
    else
      @guess_count += 1
    end
    fire if @guess_count >= 2
  end

  def on_fire(handle_fire)
    @fire_handlers << handle_fire
  end

  private

  def reset
    @active = false
    @guess_count = 0
  end

  def fire
    @active = false
    @guess_count = 0
    @fire_handlers.each { |handler| handler.call }
    @fired = true
  end
end
