require 'csv'
require 'pry'

class DinodexReader
  attr_accessor :dinos

  def initialize(path, type)
    @path = path
    @dinos = read_african_dinos(path) if type == 'african'
    @dinos = read_from_csv(path) if type == 'none'
  end

  def read_dinos
    # Format
    # {
    #   name: "Albertosaurus",
    #   period: "Late Cretaceous",
    #   continent: "North America",
    #   diet: "Carnivore",
    #   weight_in_lbs: "2000",
    #   walking: "Biped",
    #   description: "Like a T-Rex but smaller"
    # }
  end

  def read_african_dinos
    # Format
    # {
    #   genus: "Abrictosaurus",
    #   period: "Jurassic",
    #   carnivore: "No",
    #   weight: "100",
    #   walking: "Biped"
    # }
  end

end
