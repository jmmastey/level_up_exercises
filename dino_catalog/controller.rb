require 'csv'
require_relative 'transformer'
require_relative 'dinosaur'
require_relative 'catalog'
require_relative 'options_parser'

class Controller
  attr_accessor :action

  def initialize(filepaths)
    @standardized_rows    = rows(filepaths)
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

  def rows(filepaths)
    filepaths.map { |path| transform_file(path) }.flatten
  end

  def dinosaurs
    @standardized_rows.map { |row| Dinosaur.new(row) }
  end

  def catalog
    @catalog ||= Catalog.new(dinosaurs)
  end

  def transform_file(path)
    Transformer.new(path).parsed_rows
  end
end
