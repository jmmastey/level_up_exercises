require 'csv'
require_relative 'dinosaur'

# DinoDex is the main class
class DinoDex
  def initialize(dinos)
    @dinosaurs = dinos
  end

  def find_biped
    result = @dinosaurs.select(&:biped?)
    DinoDex.new(result)
  end

  def find_late_cretaceous
    result = @dinosaurs.select(&:late_cretaceous?)
    DinoDex.new(result)
  end

  def find_early_cretaceous
    result = @dinosaurs.select(&:early_cretaceous?)
    DinoDex.new(result)
  end

  def find_jurassic
    result = @dinosaurs.select(&:jurassic?)
    DinoDex.new(result)
  end

  def find_abrictosaurus
    result = @dinosaurs.select(&:abrictosaurus?)
    DinoDex.new(result)
  end

  def find_albertosaurus
    result = @dinosaurs.select(&:albertosaurus?)
    DinoDex.new(result)
  end

  def find_carnivore
    result = @dinosaurs.select(&:carnivore?)
    DinoDex.new(result)
  end

  def find_big
    result = @dinosaurs.select(&:big?)
    DinoDex.new(result)
  end

  def find_small
    result = @dinosaurs.select(&:small?)
    DinoDex.new(result)
  end
end
