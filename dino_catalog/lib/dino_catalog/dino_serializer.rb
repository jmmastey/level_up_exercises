module DinoCatalog
  class DinoSerializer
    def self.serialize_collection(dinosaurs)
      dinosaurs.map(&:to_json)
    end

    private

    def self.serialize(dinosaur)
      dino_hash = {}
      dinosaur.instance_variables.each do |variable|
        dino_hash[variable] = dinosaur.instance_variable_get(variable)
      end
      dino_hash.to_json
    end
  end
end
