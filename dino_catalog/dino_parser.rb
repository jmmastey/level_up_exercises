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
		@dinos = nil
	end

	def dinos
		return @dinos if @dinos

		@dinos = []

    CSV.foreach(@file_name, { headers: true, header_converters: :symbol}) do |row|
      p row
      puts row.inspect
      @dinos << Dino.new(row) 
    end
 
    @dinos
 
	end

end

# could have a collection object and another parser object
puts "Test"

dino_parser = DinoParser.new("dinodex.csv")
# parser = DinoParser.new("african_dinosaur_export.csv")

dino_parser.dinos
