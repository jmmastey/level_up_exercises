require 'csv'

class Dino

  attr_reader :name, :period, :continent, :diet, :weight_in_lbs, :walking, :description

  def initialize(args)
    @name = args[:name] || nil
    @period = args[:period]
    @continent = args[:continent]
    @diet = args[:diet] || args[:carnivore]
    @weight_in_lbs = args[:weight_in_lbs] || args[:weight]
    @walking = args[:walking]
    @description = args[:description]
  end

end

module DinoLoader

  def self.get_dinos_from_csv(filepath)
  	dinos = []
  	CSV.foreach(filepath, {:headers => true, :header_converters => :symbol}) do |row|
  	  dinos << Dino.new(row)
  	end
  	dinos
  end

end

class Directory

  attr_reader :dinos

  def initialize(dinos)
  	@dinos = dinos || []
  end

  def find_bipeds
  	bipeds = []
  	@dinos.each do |dino|
  	  bipeds << dino if dino.walking == "Biped"
  	end
  	bipeds
  end

  def find_carnivores
	carnivores = []
	@dinos.each do |dino|
	  eating_habbits = dino.diet
	  carnivores << dino if eating_habbits == ("Yes" || "Carnivores")
	end
	carnivores
  end

  def find_period(period)
	dinos_by_period = []
	@dinos.each do |dino|
	  dinos_by_period << dino if dino.period == period
	end
	dinos_by_period
  end

  def find_big_dinos
  	big_dinos = []
  	dinos.each do |dino|
  	  weight = dino.weight_in_lbs.to_i || dino.weight.to_i
	  big_dinos << dino if weight > 2000
	end
	big_dinos
  end

  def find_small_dinos
	small_dinos = []
	dinos.each do |dino|
	  weight = dino.weight_in_lbs.to_i || dino.weight.to_i
	  small_dinos << dino if weight < 2000
    end
    small_dinos
  end

end

dinos = DinoLoader.get_dinos_from_csv("dinodex.csv")
african_dinos = DinoLoader.get_dinos_from_csv("african_dinosaur_export.csv")
directory = Directory.new(dinos)

if ARGV[0] == "find"
  if ARGV[1] == "bipeds"
  	puts directory.find_bipeds
  elsif ARGV[1] == "carnivores"
  	puts directory.find_carnivores
  elsif ARGV[1] == "period"
  	puts directory.find_period(ARGV[2])
  elsif ARGV[1] == "big dinos"
  	puts directory.find_big_dinos
  elsif ARGV[1] == "small dinos"
  	puts directory.find_small_dinos
  end
else
  puts "Command not found."
  puts "Command include 'find' followed by: 'bipeds', 'carnivores', 'period', 'big dinos', or 'small dinos'."
end
  		

