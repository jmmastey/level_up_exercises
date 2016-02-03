# `DinoDex` creates an array of Dinosaur objects from csv data.
class DinoDex
  require 'csv'
  require_relative 'dinosaur'
  attr_accessor :dinosaurs

  def initialize
    @dinosaurs = create_dinosaurs
  end

  private

  def create_dinosaurs
    dino_array = []
    Dir.glob('*.csv').each do |file|
      table = CSV.read(file, headers: true, header_converters: :symbol,
                       converters: :all)
      table.each do |dino|
        dino_array << Dinosaur.new(formatted_data(dino))
      end
    end
    dino_array
  end

  def formatted_data(dino)
    {
      name:        dino[:name] || dino[:genus],
      period:      dino[:period],
      continent:   dino.fetch(:continent, "Africa"),
      diet:        dino.fetch(:diet) { correct_diet(dino) },
      weight:      dino[:weight_in_lbs] || dino[:weight],
      walking:     dino[:walking],
      description: dino[:description]
    }
  end

  def correct_diet(dino)
    dino[:carnivore].downcase == 'yes' ? 'Carnivore' : 'Non-carnivore'
  end
end
