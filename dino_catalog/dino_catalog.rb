require 'csv'
require_relative 'dinosaur'

class DinoCatalog
  attr_reader :dinosaurs

  def initialize
    CSV::HeaderConverters[:header_converter] = method(:header_converter)
    dinos_hash = DinoCatalog.parse_dinodex("dinodex.csv")
                 .concat(DinoCatalog.parse_african_dinosaurs)
    @dinosaurs = dinos_hash.inject([]) do |dinos, dino|
      dinos << Dinosaur.new(dino)
    end
  end

  def self.parse_dinodex(filename)
    csv = CSV.read(filename, headers: true,
          header_converters: [:downcase, :header_converter])
    csv.map(&:to_hash)
  end

  def self.parse_african_dinosaurs
    african_dinos_hash = parse_dinodex("african_dinosaur_export.csv")
    african_dinos_hash.each do |row|
      row["continent"] = "Africa"
      row["diet"] = row["diet"] == "Yes" ? "Carnivore" : "Herbivore"
    end
  end

  def header_converter(header)
    case header
      when "genus" then "name"
      when "weight_in_lbs" then "weight"
      when "carnivore" then "diet"
      else header
    end
  end
end
