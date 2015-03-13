require 'CSV'
require './dino_catalog'
require './dino'

class DinoParser
  def self.parse(files = ['dinodex.csv', 'african_dinosaur_export.csv'], dino_catalog)
    add_default_csv(files[0], dino_catalog)
    add_african_csv(files[1], dino_catalog)
  end

  private

  def self.add_default_csv(default_file_name, dino_catalog)
    @dinos = CSV.read(default_file_name,
                      headers: true,
                      header_converters: :symbol)

    @dinos.each do |dino|
      restructured_dino = {
        name: dino[:name],
        period: dino[:period],
        continent: dino[:continent],
        diet: dino[:diet],
        weight: dino[:weight_in_lbs],
        walking: dino[:walking],
        description: dino[:description]
      }

      dino_catalog.add(Dino.new(restructured_dino))
    end
  end

  def self.add_african_csv(african_file_name, dino_catalog)
    @dinos = CSV.read(african_file_name,
                      headers: true,
                      header_converters: :symbol)

    @dinos.each do |dino|
      restructured_dino = {
        name: dino[:genus],
        period: dino[:period],
        continent: 'Africa',
        diet: dino[:carnivore].downcase == 'yes' ? 'Carnivore' : 'Herbivore',
        weight: dino[:weight],
        walking: dino[:walking],
        description: dino[:description]
      }

      dino_catalog.add(Dino.new(restructured_dino))
    end
  end
end
