require 'csv'
#
class Dinosaur
    attr_reader :name
  def initialize(options)
    @name = options[:name].to_s
    @period = options[:period].to_s
    @continent = options[:continent].to_s
    @diet = options[:diet].to_s
    @weight_in_lbs = options[:weight_in_lbs].to_i
    @legs = convert_legs(options[:walking])
    @description = options[:description].to_s
  end


  def convert_legs(dino)
    if dino.downcase == "biped"
      2
    elsif dino.downcase == "quadruped"
      4
    else
      "other"
    end
  end
end

class Library
  attr_accessor :dinodex

  def initialize(file)
    @dinodex = []
    load_dinos('dinodex.csv')
    load_dinos('african_dinosaur_export.csv')
    p @dinodex[-1].name
  end

  def load_dinos(file)
    CSV.foreach(file, :headers=> true) do |row|
      dino = row.to_hash
      mapping = {"Genus" => "Name", "Carnivore" => "Diet", "Weight" => "Weight_in_lbs"}
      dino.keys.each { |k| dino[mapping[k]] = dino.delete(k) if mapping[k]}
      dino = dino.inject({}){|memo,(k,v)| memo[k.downcase.to_sym] = v; memo}
      @dinodex << Dinosaur.new(dino)
    end
  end
end

dinos = Library.new('dinodex.csv')
