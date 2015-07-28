class CodeSequence
  attr_reader :code, :default_code

  CODE_LENGTH = 4

  def initialize(default_code)
    raise('Invalid Default Code') unless valid_code?(default_code)
    @default_code = default_code
  end

  def set(code)
    is_valid = valid_code?(code)
    @code = is_valid ? code : @default_code
    is_valid
  end

  def is?(compare_code)
    @code == compare_code
  end

  private

  def valid_code?(code)
    valid_length?(code) && integer?(code)
  end

  def valid_length?(code)
    code.length == CODE_LENGTH
  end

  def integer?(obj)
    true if Integer(obj) rescue false
  end
end