require_relative 'dinodex_reader'

class Dinodex
  attr_accessor :dinosaurs

  def load_dinosaurs_file(csv_path, type = 'none')
    dinodex_reader = DinodexReader.new(csv_path, type)
    @dinosaurs = dinodex_reader.fetch
  end

  def bipeds
    @dinosaurs.select { |dino| dino.walking == 'Biped' }
  end

  def carnivores
    @dinosaurs.select { |dino| dino.diet == 'Carnivore' }
  end

  def small_dinos
    @dinosaurs.select { |dino| dino.weight_in_lbs.to_i < 2000 }
  end

  def big_dinos
    @dinosaurs.select { |dino| dino.weight_in_lbs.to_i > 2000 }
  end

end

dinodex = Dinodex.new
dinodex.load_dinosaurs_file("dinodex.csv")
