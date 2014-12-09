class Dinosaur
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
    @dinosaurs.map(&:to_json)
  end
end
