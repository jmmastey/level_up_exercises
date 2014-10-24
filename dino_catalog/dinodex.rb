require_relative 'CSVParse'

class Dinodex
  attr_reader :dinosaurs

  LARGE_WEIGHT = 2000

  def initialize(dinosaurs)
    @dinosaurs = dinosaurs
  end

  def print_all_dinos
    @dinosaurs.each do |dino|
      dino.all_variables.each { |attri| puts attri }
      puts "\n----------\n\n"
    end
  end

  def bipeds
    tmp_dino = Dinodex.new(dinosaurs.dup)
    tmp_dino.dinosaurs.keep_if do |dino|
      dino.walking == 'Biped'
    end
    tmp_dino
  end

  def carnivores
    tmp_dino = Dinodex.new(dinosaurs.dup)
    tmp_dino.dinosaurs.select { |dino| dino.carnivore == "Yes" }
    tmp_dino
  end

  def period(p)
    tmp_dino = Dinodex.new(dinosaurs.dup)
    tmp_dino.dinosaurs.keep_if do |dino|
      dino.period.downcase.include? p.downcase
    end
    tmp_dino
  end

  def small_dinosaurs
    tmp_dino = Dinodex.new(dinosaurs.dup)
    tmp_dino.dinosaurs.keep_if do |dino|
      dino.weight <= LARGE_WEIGHT
    end
    tmp_dino
  end

  def large_dionsaurs
    tmp_dino = Dinodex.new(dinosaurs.dup)
    tmp_dino.dinosaurs.keep_if do |dino|
      dino.weight > LARGE_WEIGHT
    end
    tmp_dino
  end
end
