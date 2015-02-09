require_relative 'dino_catalog'

class Dinodex
  attr_reader :dinos

  def initialize
    dino_catalog = DinoCatalog.new
    @dinos = dino_catalog.dinosaurs
  end

  def parse_input
    #Initializing the filtered dinos with all dinos initially
    filtered_dinos = @dinos

    puts "Dinosaurs with #{ARGV}" unless ARGV.empty?
    ARGV.each do|a|
      criteria = a.split(':')
      filtered_dinos = search_by_criteria(criteria[0], criteria[1], filtered_dinos)
    end
    print_dinos(filtered_dinos)
  end

  def search_by_criteria(header, value, filtered_dinos)
    #Assumes that weight is only called with big or small parameters
    if header == 'weight'
      value.downcase == 'big' ? filtered_dinos.select(&:big?)
                              : filtered_dinos.select(&:small?)
    else
      filtered_dinos.select do |dino|
        #Used include instead of == to not differentiate between early and late Cretaceous
        dino.send(header).downcase.include? (value.downcase)
      end
    end
  end

  def print_dinos(results)
    results.each do |dino|
      puts dino.to_s
    end
  end
end

def main
  dinodex = Dinodex.new
  dinodex.parse_input
end

main
