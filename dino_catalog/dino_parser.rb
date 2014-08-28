# https://github.com/jmmastey/level_up_exercises/tree/master/dino_catalog

require 'csv'

# Genus,Period,Carnivore,Weight,Walking
# Abrictosaurus,Jurassic,No,100,Biped

# NAME,PERIOD,CONTINENT,DIET,WEIGHT_IN_LBS,WALKING,DESCRIPTION
# Albertosaurus,Late Cretaceous,North America,Carnivore,2000,Biped,Like a T-Rex but smaller.

class Dino
	attr_accessor :name, :period, :continent, :diet, :weight, :walking, :description

	def initialize(row)
		@name = row[:name]
		@period = row[:period]
		@continent = row[:continent]
		@diet = row[:diet]
		@weight = row[:weight]
		@walking = row[:walking]
		@description = row[:description]
	end

end

class DinoParser
	attr_reader :file_name, :dinos

	def initialize(file_name)
		@file_name = file_name
		@dinos = []

		parse 
	end

	private
		def parse
	    CSV.foreach(@file_name, { headers: true, header_converters: :symbol} ) do |row|
	      @dinos << Dino.new(row) 
	    end
		end
end

class DinoCollection
	attr_accessor :dinos

	def initialize
		@dinos = []
	end

	def add_from_csv(file_name)
		parser = DinoParser.new(file_name)
		parser.dinos.each do |dino|
			@dinos << dino
		end
	end
end

all_the_dinos = DinoCollection.new
all_the_dinos.add_from_csv("dinodex.csv")

p all_the_dinos.dinos

