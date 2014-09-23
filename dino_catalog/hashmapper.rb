module HashMapper
  def can_map?(input)
    (key_map.values.uniq.compact - input.keys).empty?
  end

  def map(input)
    Hash[
      key_map.map do |output_key, input_key|
        [output_key, transform(output_key, input[input_key])]
      end
    ]
  end

  def key_map
    {}
  end

  def transform(_, value)
    value
  end
end
