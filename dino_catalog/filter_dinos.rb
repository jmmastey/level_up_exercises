class DinoFilter
  def self.search(dino_collection, search_attrs)
    working_collection = dino_collection
    search_attrs.each do |category, value|
      category = :carnivore_or_herbivore if category == :diet
      working_collection = find_matches(working_collection, category, value)
    end
    working_collection
  end

  def self.find_matches(dino_collection, category, value)
    matching_dinos = DinoCollection.new
    dino_collection.dinos.each do |dino|
      matching_dinos << dino if dino_match?(dino, category, value)
    end
    matching_dinos
  end

  def self.dino_match?(dino, category, value)
    case category
      when :weight_greater_than
        return !dino.weight.nil? && dino.weight > value
      when :weight_less_than
        return !dino.weight.nil? && dino.weight < value
    end
    dino.send(category).match(value)
  end
end
