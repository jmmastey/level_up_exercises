require_relative 'dinosaur.rb'
require_relative 'dinosaur_parser.rb'

class DinosaurCatalog
  def initialize
    @dinosaurs = []
  end

  def add_dinosaurs(dinosaurs)
    @dinosaurs.concat << dinosaurs
  end

end
