class TransformData
  NORMALIZE_MAPPINGS = { genus: "name", carnivore: "carnivore",
                         weight_in_lbs: "weight" }.freeze

  def self.transform(dino_info)
    normalized_info = {}
    dino_info.each do |k, v|
      normalized_info.merge!(normalize(k, v))
    end
    add_default_values(normalized_info)
  end

  def self.add_default_values(normalized_info)
    normalized_info[:continent] = normalized_info.fetch(:continent, "Africa")
    normalized_info
  end

  def self.normalize(key, value)
    return { key => value } unless NORMALIZE_MAPPINGS.key?(key)
    method_to_use = "#{NORMALIZE_MAPPINGS[key]}_transform"
    send(method_to_use, value)
  end

  def self.name_transform(value)
    { name: value }
  end

  def self.carnivore_transform(value)
    diet = value == "Yes" ? "Carnivore" : "Herbivore"
    { diet: diet }
  end

  def self.weight_transform(value)
    { weight: value }
  end
end
