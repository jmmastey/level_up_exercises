require 'csv'

class Dinosaur
	attr_accessor :genus, :period, :carnivore, :weight, :walking

	def initialize(atr)
		@genus = atr[:genus]
		@period = atr[:period]
		@carnivore = atr[:carnivore]
		@weight= atr[:weight]
		@walking = atr[:walking]
	end

end

module DinosaurFilters
	def biped_filter
		select { |dino| dino[:walking] == "Biped"}
	end
end



class Dino_catalog
	attr_accessor :ctlg, :dinosaurs

	include DinosaurFilters

	def initialize(csv)
		@dinosaurs = []
		@ctlg = parse_index(csv)
		# load_dinos
	end

	def carnivore_filter
	# Grab all the dinosaurs that were carnivores (fish and insects count).
	end

	def period_filter
	# Grab dinosaurs for specific periods (no need to differentiate between Early and Late Cretaceous, btw).
	end

	def large_size_filter
	# Grab only big (> 2 tons) or small dinosaurs.
	end

	def period_filter
		select { |dino| dino.period == 'Jurassic'}
	end

	private

	def parse_index(csv)
		csv = CSV.new( File.open(csv), :headers => true, :header_converters => :symbol)
		csv.to_a.map {|row| row.to_hash }
	end

	def load_dinos
		@ctlg.each {|dino| Dinosaur.new(dino) }
	end

end

if __FILE__ == $0
	Dino_Ctg = Dino_catalog.new(ARGV[0])
	puts Dino_Ctg.ctlg.biped_filter
	# p Dinosaur
end

