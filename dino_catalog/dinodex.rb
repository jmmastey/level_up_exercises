require './dinosaur'

class Dinodex
  attr_accessor :dino_array
  def initialize(input_dino_array)
    @dino_array = input_dino_array
  end

  def big
    big_dinos = dino_array.select { |dino| dino.weight.to_i > 4000 }
    Dinodex.new(big_dinos)
  end

  def small
    small_dinos = dino_array.select { |dino| dino.weight.to_i < 4000 }
    Dinodex.new(small_dinos)
  end

  def carnivore
    diet_array = %w(Yes Carnivore Insectivore Piscivore)
    carnivore_dinos = dino_array.select { |dino| diet_array.include? dino.diet }
    Dinodex.new(carnivore_dinos)
  end

  def biped
    biped_dinos = dino_array.select { |dino| dino.walking == "Biped" }
    Dinodex.new(biped_dinos)
  end

  def period
    puts "\n" + "Please enter period of time: "
    input_period = gets.chomp
    period_dinos = dino_array.select do |dino|
      dino.period.downcase.include?(input_period)
    end
    Dinodex.new(period_dinos)
  end

  def dino_all_facts(name)
    dino = dino_array.select { |dino| dino.name.downcase.include?(name) }
    dino[0].to_s
  end
end
