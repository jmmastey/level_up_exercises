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
    user_input = nil
    while user_input != 'exit'
      puts "\n"+'Enter: "All", "Biped", "Large", "Carnivores", "Period", or "Exit"'
      user_input = gets.downcase.strip
      catalog.send(action.get_action(user_input))
    end
  end

  def length
    dinos.length
  end

  private

  def build_dinos(filepaths)
    standardized_rows = filepaths.map { |path| standardize(path) }
    standardized_rows.flatten.map { |row| Dinosaur.new(row) }
  end

  def build_catalog
    Catalog.new(dinos)
  end

  def standardize(path)
    StandardizedData.new(path).parsed_rows
  end
end
