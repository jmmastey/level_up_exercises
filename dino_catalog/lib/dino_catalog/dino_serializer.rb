module DinoCatalog
  module DinoSerializer
    def serialize_collection
      dinosaurs.map do |dinosaur|
        serialize(dinosaur.to_h)
      end
    end

    private

    def serialize(dino_data)
      dino_data.to_json
    end
  end
end
