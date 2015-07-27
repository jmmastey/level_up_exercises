module DinoTranslator
  HEADER_MAP = {
    "genus" => "name",
    "carnivore" => "diet",
    "weight_in_lbs" => "weight",
  }

  def self.translate_key(hash, key)
    hash[HEADER_MAP[key]] = hash.delete key if HEADER_MAP.include?(key)
  end

  def self.translate_carnivore_key(h)
    carnivore_map = {
      "yes" => "carnivore",
      "no" => "",
    }
    h["carnivore"] = carnivore_map[h["carnivore"]] if h.include?("carnivore")
  end

  def self.translate_empty_weight(h)
    if h.include?("weight")
      h.delete("weight") if h["weight"].length == 0
    elsif h.include?("weight_in_lbs")
      h.delete("weight_in_lbs") if h["weight_in_lbs"].length == 0
    end
  end

  def self.translate_header(data)
    data.each { |h| h.keys.each { |k| translate_key(h, k) } }
  end

  def self.translate_data(data)
    data.each do |h|
      translate_empty_weight(h)
      translate_carnivore_key(h)
    end
  end

  def self.translate(data)
    translate_data(data)
    translate_header(data)
    data
  end
end
