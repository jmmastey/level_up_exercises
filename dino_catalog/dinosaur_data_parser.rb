require 'csv'

class DinosaurDataReader
  attr_accessor :dinosaurs
  def initialize(files_to_read) 
    @dinosaurs = {}
    parse_dino_data(files_to_read)
  end

  def parse_dino_data(files_to_read)
    files_to_read.each do |file|
      dino = CSV.new(File.read(file), headers: true, header_converters: :symbol, converters: :all)
      dino_hash = dino.to_a.map(&:to_hash)
      build_dinosaurs(dino_hash)
    end
  end
  
  def build_dinosaurs(dino_hash)
    dino_hash.each do |dinosaur|
      @dinosaurs[dinosaur[dinosaur.keys[0]]] = Dinosaur.new(dinosaur)
    end
  end
end
