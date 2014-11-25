require 'csv'
require_relative 'standardized_data'
require_relative 'dinosaur'
require_relative 'catalog'
require_relative 'options_parser'

class Controller
  attr_accessor :dinos, :catalog, :input

  def initialize(filepaths)
    @dinos = build_dinos(filepaths)
    @catalog = build_catalog
    @input = OptionsParser.new
  end

  def run
    puts 'Enter: "All", "Biped", "Large", "Carnivores", "Period", or "Exit"'
    catalog.send(input.get_action(gets.downcase.strip))
    run
  end

  def length
    dinos.length
  end

  private

  def build_dinos(filepaths)
    accumulator = []
    filepaths.map { |path| accumulator += dino_hashes(path) }
    accumulator.map { |dino_row| Dinosaur.new(dino_row) }
  end

  def build_catalog
    Catalog.new(dinos)
  end

  def dino_hashes(path)
    tmp = StandardizedData.new(path)
    tmp.rows
  end
end
