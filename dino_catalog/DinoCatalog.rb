require 'csv'
require 'pry'

class Dinosaur
	attr_accessor :genus, :period, :carnivore, :weight, :walking

	def initialize(atr = {})
		@genus = atr.fetch(:genus, "Unknown")
		@period = atr.fetch(:period, "Unknown")
		@walking = atr.fetch(:walking, "Unknown")
		@weight = atr.fetch(:weight, 0)
		@carnivore = atr.fetch(:carnivore, "Unknown")
	end

	def genus_str
			output << "Genus: #{@genus}" if @genus != "Unknown"
	end
 
	def period_str
			output << "Period: #{@period}" if @period != "Unknown"
	end

	def walking_str
			output << "Legs for Walking: #{@walking}" if @walking_str != "Unknown"
	end

	def carnivore_str
			output << "Carnivore?: #{@carnivore}" if @carnivore != "Unknown"
	end

	def weight_str
			output << "Weight (lbs): #{@weight}" if @weight != 0
	end

	def output
		binding.pry
		puts [genus_str, period_str, walking_str, carnivore_str, weight_str].join(", ")
	end

	def to_s
		"#{output}"
		# "#{genus}: #{walking} from #{period} period. Weighed #{weight}lbs and #{carnivore ? 'a carnivore' : 'not a carnivore'}"
	end
end

class Dino_catalog
	attr_reader :dinosaurs

	def initialize(csv)
		@dinosaurs = []
		@periods = []
		@transport_mode = []
		@carnivorousness = []

		parse_index(csv)
		variable_mapping()
	end

	def biped_filter()
		walking = ''

		until @transport_mode.include? walking.downcase
		  puts "What is the desired transportation mode?"
			walking = STDIN.gets.chomp
		end

		@dinosaurs.select! { |dino| dino.walking == walking}
		self
	end

	def carnivore_filter()
		carnivore = ''

		until @carnivorousness.include? carnivore.downcase
		  puts "What is the desired transportation mode?"
			carnivore = STDIN.gets.chomp
		end

		@dinosaurs.select! { |dino| dino.carnivore == carnivore}
		self
	end

	def period_filter()
		period = ''

		until @periods.include? period.downcase
		  puts "What time period?"
			period = STDIN.gets.chomp
		end

		@dinosaurs.select! { |dino| dino.period == period}
		self
	end

	def size_filter()
		weight = ''

		until ['l', 's'].include? weight.downcase
		  puts "What size (greater or less than 2 tons)? L)arge or S)mall: "
			weight = STDIN.gets.chomp
		end

		if weight == 'l'
 			@dinosaurs.select! { |dino| dino.weight.to_i > 2000 }
 		else
 			@dinosaurs.select! { |dino| dino.weight && dino.weight.to_i <= 2000}
 		end
 		self
	end

	def output
		@dinosaurs.each { |dino|
			puts dino
		}
	end

	def to_s
		"Your roladex of all #{dinosaurs.length} friendly and dead dinosaurs!"
	end

	private

	def parse_index(csv)
		csv = CSV.new( File.open(csv), :headers => true, :header_converters => :symbol)
		load_dinos( csv.to_a.map {|row| row.to_hash } )
	end

	def load_dinos(dino_hash)
		@dinosaurs =  dino_hash.map! {|dino| Dinosaur.new(dino) }
	end

	def variable_mapping
		@dinosaurs.each do |dino| 
			@periods << dino.period.downcase
			@transport_mode << dino.walking.downcase
			@carnivorousness << dino.carnivore.downcase
		end
	end

end

if __FILE__ == $0
	Dino_Ctg = Dino_catalog.new(ARGV[0])
	# puts Dino_Ctg.dinosaurs
	Dino_Ctg.size_filter.output
end