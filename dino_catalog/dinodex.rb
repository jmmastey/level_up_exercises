require_relative 'dinodex_reader'

class Dinodex
  attr_accessor :dinosaurs

  def load_dinosaurs_file(csv_path, type = 'none')
    @dinodex_reader = DinodexReader.new(csv_path, type)
    @dinosaurs = dinodex_reader.fetch
  end

  def bipeds
    @collections = @dinosaurs.select { |dino| dino.walking == 'Biped' }
    self
  end

  def carnivores
    @collections = @dinosaurs.select { |dino| dino.diet == 'Carnivore' }
    self
  end

  def small_dinos
    @dinosaurs = @dinosaurs.select { |dino| dino.weight_in_lbs.to_i < 2000 }
    self
  end

  def big_dinos
    @dinosaurs = @dinosaurs.select { |dino| dino.weight_in_lbs.to_i > 2000 }
    self
  end

end

dinodex = Dinodex.new
dinodex.load_dinosaurs_file("dinodex.csv")
