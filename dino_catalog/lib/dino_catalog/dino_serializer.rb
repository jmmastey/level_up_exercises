class DinoCatalog::DinoSerializer
  def self.export_json(dino_collection)
    dino_collection.map do |dinosaur|
      self.to_hash(dinosaur).to_json
    end
  end

  private

  def self.to_hash(dinosaur)
    dino_json = {}
    dinosaur.instance_variables.each do |variable|
      dino_json[variable] = dinosaur.instance_variable_get(variable)
    end
    dino_json
  end
end
