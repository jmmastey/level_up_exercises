class Dinosaur
  attr_accessor :dinosaurs
  def initialize(result_dinosaurs)
    @dinosaurs = result_dinosaurs
  end

  def description(name)
    @dinosaurs.select { |dinosaur|  dinosaur["NAME"] == name }
  end

  def names
    @dinosaurs.map { |dinosaur| dinosaur["NAME"] }
  end

  def to_json
    dinosaurs = []
    @dinosaurs.each do |dino|
      dinosaurs << dino.to_json
    end
    dinosaurs.to_json
  end
end
