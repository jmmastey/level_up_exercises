require 'csv'
require 'json'

class Dinosaur
	attr_accessor :genus, :period, :carnivore, :weight, :walking,
 								:name, :period, :continent, :diet, :weight_in_lbs, :walking, :description


	def initialize(atr)
		carnivore_diets = ['carnivore', 'insectivore', 'piscivore']

		if atr[:diet]
			if carnivore_diets.include? atr.fetch(:diet).downcase
				@carnivore = 'yes'
			else
				@carnivore = 'no'
			end
		elsif atr[:carnivore]
			@carnivore = atr.fetch(:carnivore).downcase
		else
			@carnivore = 'unknown'
		end

		if atr[:genus]
			@genus = atr.fetch(:genus, "unknown").downcase
		elsif atr[:name]
			@genus = atr.fetch(:name, "unknown").downcase
		else
			@genus = "unknown"
		end	

		if atr[:weight_in_lbs]
			@weight = atr.fetch(:weight_in_lbs, 0)
		elsif atr[:weight]
			@weight = atr.fetch(:weight, 0)
		else
			@weight = 0
		end

		if (@period_check = atr.fetch(:period).split(" ") ).length > 1
			@period_specific = @period_check.first.downcase
			@period = @period_check.last.downcase
		elsif @period_check.length == 1
			@period = @period_check.last.downcase
		else
			@period = "unknown"
		end

		@walking = atr.fetch(:walking, "unknown").downcase
		@continent = atr.fetch(:continent, "unknown").downcase
		@diet = atr.fetch(:diet, "unknown").downcase
		@description = atr.fetch(:description, "unknown")
		@output = []
	end

	def genus_str()
			@output << "Genus: #{@genus}" if @genus != "unknown"
	end
 
	def period_str()
			@output << "Period: #{@period_specific if @period_specific} #{@period}" if @period != "unknown"
	end

	def walking_str()
			@output << "Legs for Walking: #{@walking}" if @walking_str != "unknown"
	end

	def carnivore_str()
			@output << "Carnivore?: #{@carnivore}" if @carnivore != "unknown"
	end

	def weight_str()
			@output << "Weight (lbs): #{@weight}" if @weight != 0
	end

	def continent_str()
		@output << "Continent: #{@continent}" if @weight != "unknown"
	end
	def diet_str()
		@output << "Diet: #{@diet}" if @diet != "unknown"
	end

	def description_str()
		@output << "Description: #{@description}" if @description != "unknown"
	end

	def output_all()
		genus_str
		period_str
		walking_str
		carnivore_str
		weight_str
		continent_str
		diet_str
		description_str
		return @output.join(", ")
	end

	def to_s
		"---> #{output_all}"
	end
end

class Dino_catalog
	attr_reader :dinosaurs

	def initialize(*csv_list)
		@dinosaurs = []
		@periods = []
		@transport_mode = []
		@carnivorousness = []

		csv_list.each do |csv|
			parse_index(csv)
			variable_mapping()
		end
	end

	def biped_filter()
		walking = ''

		until ['b', 'q'].include? walking
		  puts "B)iped or Q)uadruped?"
			walking = STDIN.gets.chomp.downcase
		end

		if walking == 'b'
 			@dinosaurs.select! { |dino| dino.walking == 'biped' }
 		else
 			@dinosaurs.select! { |dino| dino.walking == 'quadruped' }
 		end
		self
	end

	def carnivore_filter()
		carnivore = ''

		until ['y', 'yes', 'n', 'no'].include? carnivore
		  puts "Is it a carnivore?"
			carnivore = STDIN.gets.chomp.downcase
		end

		if carnivore == 'y' || carnivore == 'yes'
 			@dinosaurs.select! { |dino| dino.carnivore == 'yes' }
 		else
 			@dinosaurs.select! { |dino| dino.carnivore == 'no' }
 		end
		self
	end

	def period_filter()
		period = ''

		until @periods.include? period
		  puts "What time period?"
		  puts "Options: #{@periods.uniq.join(", ")}"
			period = STDIN.gets.chomp.downcase
		end

		@dinosaurs.select! { |dino| dino.period == period}
		self
	end

	def size_filter()
		weight = ''

		until ['l', 's'].include? weight
		  puts "What size (greater or less than 2 tons)? L)arge or S)mall: "
			weight = STDIN.gets.chomp.downcase
		end

		if weight == 'l'
 			@dinosaurs.select! { |dino| dino.weight.to_i > 2000 }
 		else
 			@dinosaurs.select! { |dino| dino.weight && dino.weight.to_i <= 2000}
 		end
 		self
	end

	def output()
		if @dinosaurs.length > 0
			@dinosaurs.each { |dino|
				puts dino
			}
		else
			puts 'No dinosaurs fit your criteria.'
		end
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
	  dino_hash.map! {|dino| @dinosaurs << Dinosaur.new(dino) }
	end

	def variable_mapping()
		@dinosaurs.each do |dino| 
			@periods << dino.period.downcase
			@transport_mode << dino.walking.downcase
			@carnivorousness << dino.carnivore.downcase
		end
	end

end

if __FILE__ == $0
	Dino_Ctg = Dino_catalog.new(ARGV[0], ARGV[1])
	# Add filters here if needed
	Dino_Ctg.biped_filter.carnivore_filter.period_filter.size_filter.output
end