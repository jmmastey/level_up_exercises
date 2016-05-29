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

	def find_walking(walking)
		dinos_by_walking = []
		@dinos.each do |dino|
			dinos_by_walking << dino if dino.walking == walking
		end
		dinos_by_walking
	end

	def find_carnivores
		carnivores = []
		@dinos.each do |dino|
			eating_habbits = dino.diet
			carnivores << dino if eating_habbits == ("Yes" || "Carnivore")
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

	def find_big_dino
		big_dinos = []
		dinos.each do |dino|
			weight = dino.weight_in_lbs.to_i || dino.weight.to_i
			big_dinos << dino if weight > 2000
		end
		big_dinos
	end


end