require 'csv'
require 'pry'
require './dinosaur'

class CSVParser
  def self.read(*filenames)
    dino_array = filenames.each_with_object([]) do |filename, dinos|
      CSV.foreach(filename, headers: true, header_converters: :downcase) do |row|
        dinos << row.to_hash
      end
    end
    dino_objects(dino_array)
  end

  def self.fix_each_dino(dino)
    dino["name"] = dino.delete "genus"
    dino["weight_in_lbs"] = dino.delete "weight"
    dino["diet"] = dino.delete "carnivore"
    dino["diet"] = "carnivore" if dino["diet"] == "Yes"
    dino["diet"] = "herbivore" if dino["diet"] == "No"
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
    dinos = dinos.map do |dino|
      Dinosaur.new(dino)
    end
  end
end
