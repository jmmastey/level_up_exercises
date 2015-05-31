require 'csv'
require_relative 'dinosaur.rb'

# DinoDex is the main class
class DinoDex
  SIZE_VALUE = 4000
  NAME_CONVERTER = lambda do |field|
    field = 'NAME' if field == 'Genus'
    field
  end

  DIET_CONVERTER = lambda do |field|
    field = 'DIET' if field == 'Carnivore'
    field
  end

  WEIGHT_CONVERTER = lambda do |field|
    field = 'WEIGHT_IN_LBS' if field == 'Weight'
    field
  end

  CONVERTERS = [DIET_CONVERTER, WEIGHT_CONVERTER, NAME_CONVERTER, :downcase]
  def initialize(name_csv)
    @dinosaurs = []
    CSV.foreach(name_csv,
                headers: true,
                header_converters: CONVERTERS)do |row|
      a = Dinosaur.new(row.to_hash)
      @dinosaurs << a
    end
  end

  def find_biped
    result = @dinosaurs.select(&:biped?)
    print_val(result.to_s)
    Dinosaur.new(result.to_s)
  end

  def find_late_cretaceous
    result = @dinosaurs.select(&:late_cretaceous?)
    print_val(result.to_s)
    Dinosaur.new(result.to_s)
  end

  def find_early_cretaceous
    result = @dinosaurs.select(&:early_cretaceous?)
    print_val(result.to_s)
    Dinosaur.new(result.to_s)
  end

  def find_jurassic
    result = @dinosaurs.select(&:jurassic?)
    print_val(result.to_s)
    Dinosaur.new(result.to_s)
  end

  def find_abrictosaurus
    result = @dinosaurs.select(&:abrictosaurus?)
    print_val(result.to_s)
    Dinosaur.new(result.to_s)
  end

  def find_albertosaurus
    result = @dinosaurs.select(&:albertosaurus?)
    print_val(result.to_s)
    Dinosaur.new(result.to_s)
  end

  def find_carnivore
    result = @dinosaurs.select(&:carnivore?)
    print_val(result.to_s)
    Dinosaur.new(result.to_s)
  end

  def find_big
    result = @dinosaurs.select(&:big?)
    print_val(result.to_s)
    Dinosaur.new(result.to_s)
  end

  def find_small
    result = @dinosaurs.select(&:small?)
    print_val(result.to_s)
    Dinosaur.new(result.to_s)
  end

  def print_val(results)
    results.gsub!(/@/, ' ')
    results.gsub!(/#/, "\r\n")
    puts results
  end
end
