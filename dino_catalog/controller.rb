require 'csv'
require_relative 'standardized_data'
require_relative 'dinosaur'
require_relative 'catalog'
require_relative 'options_parser'

class Controller
  attr_accessor :action

  def initialize(filepaths)
    @standardized_data     = standardize_data(filepaths)
    @action                = OptionsParser.new
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

  # returns a value, its a query
  def rows(filepaths)
    standardized_rows = filepaths.map { |path| parse_file(path) }
    standardized_rows.flatten
  end

  def dinosaurs
    @standardized_data.map { |row| Dinosaur.new(row) }
  end

  def catalog
    # memoize
    @catalog ||= Catalog.new(dinosaurs)
  end

  def parse_file(path)
    Transformer.new(path).parsed_rows
  end
end
