require_relative 'dinosaur'
require_relative 'parser'

class DinosaurLoader
  def self.load(file)
    dinosaurs = []
    parse_file(file).each do |dino|
      dinosaurs << Dinosaur.new(dino)
    end
    dinosaurs
  end

  def self.parse_file(file)
    parser = Parser.new(file)
    parser.parse
  end
end
