require 'csv'
require './parse_files'
require './dinosaur'

class DinoLibrary

  attr_accessor :dinos, :dino_library

  def initialize
    parser = ParseFiles.new
    self.dino_library = parser.parse_files(["dinodex.csv", "african_dinosaur_export.csv"])
     @dinos = dino_library.collect do |line|
      Dinosaur.new(line)
     end
    # dino_hashes.each do |dino|
    #  #puts dino.inspect
    # end
  end

  def prompt_user
    puts "Hello. Welcome to DinoDex Catalog. Please choose any or all of the following options-"
    puts "Walking-Biped or Quadriped\nDiet-Insectivore or Carnivore or Piscivore\nWeight-4400 (or specify weight in tonnes)\nContinent-North America, Europe, Asia
Period-Jurassic or Early or Late.\nElse if you simply know the name of the dinosaur and want all details about it, type in: Information-name_of_dinosaur\n"
  end

  def user_input
    prompt_user
    user_inp = gets.chomp.split(/[,-]/).each(&:lstrip!)
    begin
      criteria = Hash[*user_inp]
    rescue Exception => e
      puts "Please enter valid criteria like this: Walking-Biped, Diet-Carnivore, Period-Jurassic, etc.."
    end
    @dinos.select! { |dino| dino.match_criteria(criteria)}
    @dinos.each do |dino| puts dino.inspect
    end
  end


dinosaurs = DinoLibrary.new
dinosaurs.user_input

end
