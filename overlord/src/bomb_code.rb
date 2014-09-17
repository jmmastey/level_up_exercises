
class BombCode
  def initialize(code)
    raise(ArgumentError, "invalid code #{code}") unless valid_code(code)
    @code = code
  end

  def ==(other)
    if other.is_a? BombCode
      @code == other.instance_variable_get(:@code)
    else
      false
    end
  end

  def to_s
    @code
  end

  private

  def valid_code(code)
    schema = /(^\d{4}$)/
    code =~ schema
  end
end
