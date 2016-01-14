

class DinoFilter
  def self.filter_by_category_value(dino_collection, category, value)
    category = special_searches(category, value)
    matching_dinos = []
    dino_collection.collection_of_dinos.each do |dino|
      matching_dinos << dino if dino.send(category).match(value)
    end
    result = create_filtered_dino_collection(matching_dinos)
  end

  def self.create_filtered_dino_collection(dino_objects)
    new_collection = DinoCollection.new
    new_collection.add_many_dinos(dino_objects)
    new_collection
  end

  def searches_selector(category, value)
    case category
    when "diet" then return "Carnivore?"
    end
  end

end
