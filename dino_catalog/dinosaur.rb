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
    dinosaur = {}
    @dinosaurs.each_with_index do |dino, index|
      dinosaur[index] = dino.to_json
    end
    dinosaur.to_json
  end
end
