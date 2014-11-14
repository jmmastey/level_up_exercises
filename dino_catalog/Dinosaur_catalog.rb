require 'csv'
require_relative 'dinosaurs.rb'

class DinoDex
  attr_accessor :dinos

  def initialize(dinos = [])
    @dinos = dinos
  end

  def parser_file(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      dino = row.to_hash
      mapping = { genus: :name, carnivore: :diet, weight: :weight_in_lbs }
      dino.keys.each { |k| dino[mapping[k]] = dino.delete(k) if mapping[k] }
      @dinos << Dinosaurs.new(dino)
    end
    @dinos
  end

  def bipeds
    @dinos.select do |dino|
      dino.walking == "Biped"
    end
  end

  def small
    @dinos.select do |dino|
      dino.weight.to_i <= 2000
    end
  end

  def big
    @dinos.select do |dino|
      dino.weight.to_i > 2000
    end
  end

  def carnivores
    @dinos.select do |dino|
      dino if dino.diet != 'Herbivore'
    end
  end

  def periods(periods)
    # puts periods
    @dinos.select do |dino|
      dino.period.downcase.include? periods
    end
  end

  def to_json
    @dinos.to_json
  end
end
