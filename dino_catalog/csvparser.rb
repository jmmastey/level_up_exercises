require 'csv'
require 'json'
require_relative 'dinosaur.rb'

CSV::Converters[:blank_to_nil] = lambda do |field|
  field && field.empty? ? nil : field
end

CSV_HEADER_CONVERTERS = {
                          headers: true,
                          header_converters: :symbol,
                          converters: [:all, :blank_to_nil],
                        }

class CSVParser
  def african_dino_import
    master_dinosaur_list = []
    CSV.foreach("african_dinosaur_export.csv", CSV_HEADER_CONVERTERS) do |dino|
      african_dino = {
        name: dino[:genus],
        period: dino[:period],
        continent: "Africa",
        diet: carnivore_to_diet(dino[:carnivore]),
        weight_in_lbs: dino[:weight],
        walking: dino[:walking],
      }
      master_dinosaur_list << Dinosaur.new(african_dino)
    end
    master_dinosaur_list
  end

  def carnivore_to_diet(diet)
    diet == "Yes" ? "Carnivore" : "Herbivore"
  end

  def dino_import
    master_dinosaur_list = []
    CSV.foreach("dinodex.csv", CSV_HEADER_CONVERTERS) do |dino|
      dinosaur = {
        name: dino[:name],
        period: dino[:period],
        continent: dino[:continent],
        diet: dino[:diet],
        weight_in_lbs: dino[:weight_in_lbs],
        walking: dino[:walking],
        description: dino[:description],
      }
      master_dinosaur_list << Dinosaur.new(dinosaur)
    end
    master_dinosaur_list
  end

  def generate_master_dinosaur_list
    african_dino_import.concat(dino_import)
  end
end
