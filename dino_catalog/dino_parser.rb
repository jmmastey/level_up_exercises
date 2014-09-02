require 'csv'

class Dino
	attr_accessor :name, :period, :continent, :diet, :weight_in_lbs, :walking, :description

	def initialize(row)
		row.each do |key, val| 
			val = val.downcase if val.is_a? String
			instance_variable_set("@#{key}",val) 
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

	def to_hash
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
    hash
	end

	def to_s
		to_hash.map{ |key, val| "#{key.capitalize}: #{val}" }.join(" --- ")
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
	      @dinos << Dino.new(standardize_row(row)) 
	    end
		end

		def standardize_row(row_in)
			row = row_in.to_hash.reject{ |key, val| val == nil }

			row[:name] = row.delete :genus if row.has_key? :genus
			row[:weight_in_lbs] = kg_to_lbs(row.delete :weight) if row.has_key? :weight

			if row.has_key? :carnivore
				is_carnivore = row[:diet] = (row.delete :carnivore).downcase
				if is_carnivore == "yes"
					row[:diet] = "carnivore"
				elsif is_carnivore == "no"
					row[:diet] = "herbivore"
				end
			end
			
			row[:continent] = "Africa" if !row.has_key? :continent

			row 
		end

		def kg_to_lbs(num_kg)
			(num_kg.to_f / 2.20462).to_i
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


	def print_all
		puts "\n-------------------All The Dinos-------------------"
		puts dinos.map(&:to_s)
	end

	def print_bipeds
		puts "\n-------------------Bipeds-------------------"
		puts bipeds.map(&:to_s)
	end

	def print_meat_eaters
		puts "\n-------------------Meat eaters-------------------"
		puts meat_eaters.map(&:to_s)
	end

	def print_from_period(period)
		puts "\n-------------------Period (#{period})-------------------"
		puts from_period(period).map(&:to_s)
	end

	def print_weighs_more_than(weight)
		puts "\n-------------------Weighs more than #{weight} lbs-------------------"
		puts weighs_more_than(weight).map(&:to_s)
	end

	private
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
end

class Controller
	attr_accessor :all_the_dinos

	def initialize
		@all_the_dinos = DinoCollection.new
		populate_directory
		welcome
	end

	def welcome
		print_welcome_message
		make_choices
	end

	def make_choices
		print_choice_menu	
		choice = gets.chomp.downcase

		case choice
		when 'all'
			all_the_dinos.print_all
		when 'params'
			search_by_params_hash
		when 'add'
			new_csv
		when 'exit'
			exit
		when "examples"
			print_examples
		else
			puts "\nWhoops! '#{choice}' is not one of the options :("
		end
		make_choices
	end


	private

		def search_by_params_hash
			# I can pass in a hash, and I'd like to get the proper list of dinos back out
			puts "Please enter a hash of search params:"
			puts "example: { period: 'cretaceous', diet: 'carnivore' }"

			hash = { period: 'cretaceous', diet: 'carnivore' }
			# hash = gets.chomp
			puts hash
			puts "\nSearch results:"
			puts find_dinos_by_params(hash).map(&:to_s)	
		end

		def find_dinos_by_params(filter_params)
			filtered_dinos = all_the_dinos.dinos

			filter_params.each do |key, val|
				filtered_dinos.select!{ |d| d.send(key) == val }
			end

			filtered_dinos
		end

		def new_csv
			puts "Please enter the filename:"
			filename = gets.chomp
			all_the_dinos.add_from_csv(filename)
		end

		def populate_directory
			all_the_dinos.add_from_csv("dinodex.csv")
			all_the_dinos.add_from_csv("african_dinosaur_export.csv")
		end

		def print_welcome_message
			puts "\nWelome to the Dino Directory!!!!!"
		end

		def print_choice_menu
			puts "----------------------------------------------------------"
			puts "\nWhat would you like to do?"
			puts "  - Enter 'all' to print all dinos"
			puts "  - Enter 'params' to print dinos with specific parameters"
			puts "  - Enter 'add' to add new dinos via CSV"
			puts "  - Enter 'examples' for preset filters"
			puts "  - Enter 'exit' to exit"
		end

		def print_examples
			all_the_dinos.print_bipeds
			all_the_dinos.print_meat_eaters
			all_the_dinos.print_from_period("permian")
			all_the_dinos.print_from_period("jurassic")
			all_the_dinos.print_weighs_more_than(2000)
			all_the_dinos.print_weighs_more_than(1999)
		end

end


controller = Controller.new


# all_the_dinos
# all_the_dinos.print_all

