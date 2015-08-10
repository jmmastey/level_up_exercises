module Filterable
  def eql?(key, value)
    instance_variable_get("@#{key}").to_s.downcase.eql?(value.to_s.downcase)
  end

  def greater_than?(key, value)
    instance_variable_get("@#{key}").to_i >= value.to_i
  end

  def less_than?(key, value)
    !greater_than?(key, value)
  end

  def not_eql?(key, value)
    !eql?(key, value)
  end

  def contains(key, value)
    instance_variable_get("@#{key}").to_s.downcase.include?(value.downcase)
  end
end
