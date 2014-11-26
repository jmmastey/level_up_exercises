require 'csv'
require_relative 'standardized_data'
require_relative 'dinosaur'
require_relative 'catalog'
require_relative 'options_parser'

class Controller
  attr_accessor :dinos, :catalog, :action

  def initialize(filepaths)
    @dinos = build_dinos(filepaths)
    @catalog = build_catalog
    @action = OptionsParser.new
  end

  def run
    puts "\n\nEnter: \"All\", \"Biped\", \"Large\", \"Carnivores\", \"Period\", or \"Exit\""
    catalog.send(action.get_action(gets.downcase.strip))
    run
  end

  def length
    dinos.length
  end

  private

  def build_dinos(filepaths)
    accumulator = []
    filepaths.map { |path| accumulator += standardize(path) }
    accumulator.map { |row| Dinosaur.new(row) }
  end

  def build_catalog
    Catalog.new(dinos)
  end

  def standardize(path)
    StandardizedData.new(path).rows
  end
end
