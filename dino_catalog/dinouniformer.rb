module DinoUniformer
  HEADER_MAP = {
    "genus" => "name",
    "carnivore" => "diet",
    "weight_in_lbs" => "weight",
  }

  CARNIVORE_MAP = {
    "yes" => "Carnivore",
    "no" => "Herbivore",
  }

  def self.uniform_keys(header)
    HEADER_MAP.each do |old_key, new_key|
      next unless header.key?(old_key)
      value = header.delete(old_key)
      header[new_key] = value
    end
  end

  def self.uniform_header(data)
    data.each { |header| uniform_keys(header) }
  end

  def self.uniform_data(data)
    data.each do |row|
      uniform_weight(row)
      uniform_carnivore(row)
    end
  end

  def self.uniform_carnivore(row)
    return unless row.key?("diet")
    diet = row["diet"].downcase
    return unless %w(yes no).include?(diet)
    
    row["diet"] = CARNIVORE_MAP[diet]
  end

  def self.uniform_weight(row)
    return unless row.key?("weight")
    row.delete("weight") if row["weight"].length == 0
  end

  def self.uniform(data)
    uniform_header(data)
    uniform_data(data)
  end

end
