class Criterium
  def initialize(criterium)
    @tokens = criterium.split
    set_defaults
    process_tokens
  end

  def to_hash
    filter_args = {}
    filter_args[@field.to_sym] = @value
    filter_args.merge!(op: @op, negate: @negate)
    filter_args
  end

  private

  def process_tokens
    @field = @tokens.shift
    if boolean?
      process_boolean
    else
      process_op
      process_value
    end
  end

  def boolean?
    %w(is are).include?(@field)
  end

  def negation?(token)
    @negate = token != "!="
    @negate &&= (%w(not !).include?(token) || token[0] == "!")
    @negate
  end

  def process_boolean
    @field = @tokens.shift
    @op = "=="
    @value = true
    @field = process_negation(@field)
  end

  def process_negation(token)
    return token unless negation?(token)
    if token[0] == "!"
      token[0] = ""
    else
      token = @tokens.shift
    end
    token
  end

  def process_op
    @op = @tokens.shift
    process_negation(@op)
  end

  def process_value
    val = @tokens.join(" ")
    @value = typecast(val)
  end

  def set_defaults
    @negate = false
    @field = ""
    @op = "=="
    @value = ""
  end

  def make_numeric_if_applicable(item)
    Float(item)
  rescue TypeError, ArgumentError
    item
  end

  def typecast(item)
    item = make_numeric_if_applicable(item)
    item = true if item.is_a?(String) && item.downcase == "true"
    item = false if item.is_a?(String) && item.downcase == "false"
    item
  end
end
