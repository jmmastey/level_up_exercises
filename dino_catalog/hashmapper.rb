module HashMapper
  def can_map?(input)
    # Check to make sure that all of the keys defined in key_map are also part
    # of the keys in the input hash
    # The map allows output to map to nil, so compacting mey_map valies to
    # remove checking for nil values.
    (key_map.values.compact - input.keys).empty?
  end

  def map(input)
    # Using a key map that is defined as a hash:
    #    { key_out => key_in, ... }
    # and transform function
    # Translate an input hash key and value using the transform function
    # IE:
    #   input = { key_in => value }
    #   result = { key_out => transformed_value }
    key_map.each_with_object({}) do |(key_out, key_in), hash|
      hash[key_out] = transform(key_out, input[key_in])
    end
  end

  def key_map
    # sample map:
    # { key_out: "key_in", }
    raise NotImplementedError
  end

  def transform(_, value)
    value
  end
end
