require_relative './code_sequence.rb'

class Bomb
  attr_reader :activation_code, :deactivation_code

  DEFAULT_ACTIVATION_CODE = '1234'
  DEFAULT_DEACTIVATION_CODE = '0000'

  def initialize
    @activation_code = CodeSequence.new(DEFAULT_ACTIVATION_CODE)
    @deactivation_code = CodeSequence.new(DEFAULT_DEACTIVATION_CODE)
  end
end
