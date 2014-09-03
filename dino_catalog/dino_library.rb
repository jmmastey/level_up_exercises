require 'csv'
require './file_parser'
require './dinosaur'
require 'pp'

class DinoLibrary
  def initialize
    dino_library = FileParser.parse(["dinodex.csv", "african_dinosaur_export.csv"])
    @dinos = dino_library.collect do |line|
      Dinosaur.new(line)
    end
  end

  def prompt_user
    print "Hello. Welcome to DinoDex Catalog.\nPlease choose any or all of the following options- Walking-Biped or Quadriped\nDiet-Insectivore or Carnivore or Piscivore\nWeight-4400 (or specify weight in tonnes)\nContinent-North America, Europe, Asia
Period-Jurassic or Early or Late.\nElse if you simply know the name of the dinosaur and want all details about it, type in: Information-name_of_dinosaur\n"
  end

  def user_input
    begin
      prompt_user
      tokenized_inp = tokenize_user_input(gets)
      criteria = Hash[*tokenized_inp]
      @dinos.select { |dino| dino.match_criteria(criteria)}
    rescue
      raise "Please enter valid criteria like this: Walking-Biped, Diet-Carnivore, Period-Jurassic, etc.."
      retry
    end
    @dinos.each do |dino| puts dino.to_s
    end
  end

  def tokenize_user_input(input_string)
    tokenized_string = input_string.split(/[,-]/).each(&:strip!)
    tokenized_string
  end

  dinosaurs = DinoLibrary.new
  dinosaurs.user_input

end
