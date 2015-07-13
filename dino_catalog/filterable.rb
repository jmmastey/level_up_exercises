class Filterable
  def filter(key, value)
    instance_variable_get("@#{key}") == value
  end

  def greater_than?(key, value)
    instance_variable_get("@#{key}").to_i >= value.to_i
  end

  def less_than(key, value)
    !greater_than?(key, value)
  end

  def not_eql?(key, value)
    !filter(key, value)
  end

  def contains(key, value)
    instance_variable_get("@#{key}").to_s.include?(value)
  end
end
