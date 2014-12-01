require 'csv'
require_relative 'standardized_data'
require_relative 'dinosaur'
require_relative 'catalog'
require_relative 'options_parser'

class Controller
  attr_accessor :standardized_data, :catalog, :action

  def initialize(filepaths)
    @standardized_data    = standardize_data(filepaths)
    @catalog              = build_catalog
    @action               = OptionsParser.new
  end

  def run
    user_input = nil
    while user_input != 'exit'
      puts "\n" + 'Enter: "All", "Biped", "Large", "Carnivores", "Period", or "Exit"'
      user_input = gets.downcase.strip
      catalog.send(action.get_action(user_input))
    end
  end

  private

  def standardize_data(filepaths)
    standardized_rows = filepaths.map { |path| parse_file(path) }
    standardized_rows.flatten
  end

  def build_catalog
    dinosaurs = standardized_data.map { |row| Dinosaur.new(row) }
    Catalog.new(dinosaurs)
  end

  def parse_file(path)
    StandardizedData.new(path).parsed_rows
  end
end
