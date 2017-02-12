module DinoCatalog
  class DinoSerializer
    def self.serialize_collection(dinosaurs)
      dinosaurs.map do |dinosaur|
        binding.pry
        DinoSerializer.serialize(dinosaur.to_h)
      end
    end

    private

    def self.serialize(dino_hash)
      dino_hash.to_json
    end
  end
end
