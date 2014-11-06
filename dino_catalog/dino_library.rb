require 'csv'
require './file_parser'
require './dinosaur'
require 'pp'
require './user_input'
require 'pry'

class DinoLibrary
  def initialize
    dino_library = FileParser.parse(["dinodex.csv", "african_dinosaur_export.csv"])
    @dinos = dino_library.collect do |line|
      Dinosaur.new(line)
    end
  end

  def user_input
    begin
      dino_list = nil
      UserInput.prompt_user
      user_response = gets.chomp
      tokenized_inp = UserInput.tokenize_user_input(user_response)
      criteria = Hash[*tokenized_inp]
      dino_list ||= @dinos
      dino_list = dino_list.select { |dino| dino.match_criteria(criteria)}
    rescue
      raise "Please enter valid criteria like this: Walking-Biped, Diet-Carnivore, Period-Jurassic, etc.."
    end
    print_dinos(dino_list)
    UserInput.search_again
  end

  def print_dinos(dino_list)
    dino_list.each do |dino| puts dino.to_s
    end
  end

  dinosaurs = DinoLibrary.new
  dinosaurs.user_input

end
