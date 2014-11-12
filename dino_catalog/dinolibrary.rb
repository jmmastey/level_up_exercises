require_relative 'dinosaur.rb'
require 'csv'

# This class does the search for dinosaurs based on user input criteria
class DinoLibrary
  attr_accessor :dino_table

  def initialize(file_array)
    @dino_table = []
    file_array.each do |file|
      CSV.foreach(file, headers: true, header_converters: :downcase) do |row|
        @dino_table << Dinosaur.new(row.to_hash)
      end
    end
  end

  def grab_dinos(user_question = {})
    result = @dino_table
    user_question.each do |key, value|
      result = send("search_by_#{key}", result, value)
    end
    result
  end

  def search_by_name(dinos, name)
    dinos.select { |dino| dino.name.upcase == name }
  end

  def search_by_diet(dinos, diet)
    if diet == 'CARNIVORE'
      dinos.select { |dino| dino.diet.upcase != 'HERBIVORE' }
    else
      dinos.select { |dino| dino.diet.upcase == 'HERBIVORE' }
    end
  end

  def search_by_walking(dinos, walking)
    dinos.select { |dino| dino.walking.upcase == walking }
  end

  def search_by_size(dinos, size)
    dinos.select { |dino| dino.size.upcase == size }
  end

  def search_by_period(dinos, period)
    dinos.select { |dino| dino.period.upcase.include? period }
  end

  def all_dinosaurs
    hash_obj = []
    @dino_table.each { |dino| hash_obj << dino.to_h }
    hash_obj
  end
end
