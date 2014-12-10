require 'pry'
class Bomb
  attr_accessor :activatecode, :deactivationcode, :attempts,
                :exploded, :active

  def initialize(activecode, deactivecode)
    @activatecode = verify_set_code('activation', activecode)
    @deactivationcode = verify_set_code('deactivation', deactivecode)
    @attempts = 0
    @exploded = false
    @active = false
  end

  def activate?(code)
    @active = (code == @activatecode) && !@exploded
  end

  def deactivate(stopcode)
    @active = false if (stopcode == @deactivationcode) && !@exploded
    @exploded = true if @attempts >= 2 && @active
    @attempts += 1
  end

  private

  def verify_set_code(code_type, code)
    fail ArgumentError if !code.empty? && !(code =~ /^\d+$/)
    if code_type == 'activation' && code.empty?
      code = '1234'
    elsif code_type == 'deactivation' && code.empty?
      code = '0000'
    end
    code
  end
end
