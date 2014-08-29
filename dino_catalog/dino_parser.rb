require 'csv'

class Dino
	attr_accessor :name, :period, :continent, :diet, :weight_in_lbs, :walking, :description

	def initialize(row)
		p row
		@name = row[:name]
		@period = row[:period]
		@walking = row[:walking]
		@description = row[:description]
		@diet = row[:diet]

		if row.has_key? :name
			@name = row[:name] 
		else
			@name = row[:genus]
		end

		if row.has_key? :weight_in_lbs 
			@weight_in_lbs = row[:weight_in_lbs] 
		else
			@weight_in_lbs = row[:weight]
		end

		if row.has_key? :carnivore
			is_carnivore = row[:carnivore].downcase
			if is_carnivore == "yes"
				@diet = "carnivore"
			elsif is_carnivore == "no"
				@diet = "herbivore"
			end
		end

		if row.has_key? :continent
			@continent = row[:continent]
		else
			@continent = "Africa"
		end	
	end

	def weight_in_lbs
		@weight_in_lbs.to_i
	end

	def is_biped?
		@walking.downcase == "biped"
	end

	def eats_meat?
		["carnivore", "insectivore", "piscivore"].include? @diet.downcase 
	end

	def from_period?(period_name)
		@period.downcase.include? period_name.downcase
	end

	def to_s
		"Name: #{name}; Period: #{period}, Continent"
	end

end

class DinoParser
	attr_reader :file_name, :dinos

	def initialize(file_name)
		@file_name = file_name
		@dinos = []

		parse_csv 
	end

	private
		def parse_csv
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

	def bipeds
		@dinos.select { |d| d.is_biped? }
	end

	def meat_eaters
		@dinos.select { |d| d.eats_meat? }
	end

	def from_period(period)
		@dinos.select { |d| d.from_period?(period) }
	end

	def weighs_more_than(weight)
		@dinos.select { |d| d.weight_in_lbs > weight }
	end

	def print_bipeds
		p "-------------"
		bipeds.each do |d| 
			p "#{d.name} #{d.walking}"
		end
	end

	def print_meat_eaters
		p "-------------"
		meat_eaters.each do |d| 
			p "#{d.name} #{d.diet}"
		end
	end

	def print_from_period(period)
		p "-------------"
		from_period(period).each do |d| 
			p "#{d.name} #{d.period}"
		end
	end

	def print_weighs(weight)
		p "-------------"
		weighs_more_than(weight).each do |d| 
			p "#{d.name} #{d.weight_in_lbs}"
		end
	end
end

all_the_dinos = DinoCollection.new
all_the_dinos.add_from_csv("dinodex.csv")
all_the_dinos.add_from_csv("african_dinosaur_export.csv")

p "-------------"
all_the_dinos.dinos.each do |d|
	p d
end


all_the_dinos.print_bipeds
all_the_dinos.print_meat_eaters
all_the_dinos.print_from_period("permian")
all_the_dinos.print_from_period("jurassic")
all_the_dinos.print_weighs(2000)
all_the_dinos.print_weighs(1999)

