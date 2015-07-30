class CodeSequence
  attr_reader :code, :default_code, :check_attempts

  CODE_LENGTH = 4
  MAX_CHECK_ATTEMPTS = 2

  def initialize(default_code)
    raise('Invalid Default Code') unless valid_code?(default_code)
    @default_code = default_code
    @check_attempts = 0
  end

  def set(code)
    code ||= @default_code
    @is_valid = valid_code?(code)
    @is_valid && (@code = code)
    @is_valid
  end

  def check(compare_code)
    @is_valid = @code == compare_code
    @check_attempts = @is_valid ? 0 : @check_attempts + 1
    @is_valid
  end

  def exceded_max_attempts
    @check_attempts > MAX_CHECK_ATTEMPTS
  end

  def status
    { is_valid: @is_valid, exceded_max_attempts: exceded_max_attempts  }
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
