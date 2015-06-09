require 'csv'
require 'pry'
require './dinosaur'

class CSVParser
  def self.read(*filenames)
    filenames.each_with_object([]) do |filename, dinos|
      CSV.foreach(filename, headers: true, header_converters: :downcase) do |row|
        dinos << row.to_hash
      end
      dino_objects(dinos)
    end
  end

  def self.fix_each_dino(dino)
    dino["name"] = dino.delete "genus"
    dino["weight_in_lbs"] = dino.delete "weight"
    dino["diet"] = dino.delete "carnivore"
    dino["continent"] = "Africa"
    dino["description"] = nil
  end

  def self.dinos_convert(dinos)
    dinos.each do |dino|
      fix_each_dino(dino) if dino.key?("genus")
    end
    dinos
  end

  def self.dino_objects(dinos)
    dinos = dinos_convert(dinos)
    dinos.map do |dinos|
      Dinosaur.new(dinos)
    end
  end
end
