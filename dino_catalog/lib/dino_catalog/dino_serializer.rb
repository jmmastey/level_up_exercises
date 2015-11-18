class DinoCatalog::DinoSerializer
  def self.export_json(dino_collection)
    dino_collection.map do |dinosaur|
      dinosaur.to_json
    end
  end

  # private

  # def self.to_json(dinosaur)
  #   dino_hash = {}
  #   dinosaur.instance_variables.each do |variable|
  #     dino_hash[variable] = dinosaur.instance_variable_get(variable)
  #   end
  #   dino_hash.to_json
  # end
end
