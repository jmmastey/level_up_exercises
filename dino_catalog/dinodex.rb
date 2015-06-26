require 'csv'
require 'json'

class Dino
	attr_accessor :name, :period, :continent, :diet
	attr_accessor :weight, :walking, :description

	def initialize( data )
		@name = data['name'] || data['genus']
		@period = data['period']
		@continent = data['continent']

		@diet = data['diet'] || ( data['carnivore'] ? 'Carnivore' : nil )
		@weight = data['weight_in_lbs'] || data['weight']

		@walking = data['walking']
		@description = data['description']
	end

	def dino_facts
		puts "Name:\t\t#{name}"
		puts "Diet:\t\t#{diet}" if diet
		puts "Weight:\t\t#{weight} lbs" if weight
		puts "Walking:\t#{walking}" if walking
		puts "Period:\t\t#{period}"
		puts "Continent:\t#{continent}" if continent
		puts "Description:\t#{description}" if description
		puts
	end

	def to_h
		{
			'name' => name,
			'period' => period,
			'continent' => continent,
			'diet' => diet,
			'weight' => weight,
			'walking' => walking,
			'description' => description
		}
	end
end


class Dinodex
	attr_accessor :dinos

	def initialize( dinos )
		@dinos = dinos || []
	end

	def index
		@dinos.each{ |dino| dino.dino_facts() }
	end

	def compare( field, val1, val2 )
		if field == 'weight'
			val1.to_i <=> val2.to_i
		else
			val1 <=> val2
		end
	end

	def lt( field, value )
		Dinodex.new(
			@dinos.select{ |dino|
				next if (actual = dino.send(field)).nil?
				compare(field, actual.downcase, value.downcase) < 0
			}
		)
	end

	def gt( field, value  )
		Dinodex.new(
			@dinos.select{ |dino|
				next if (actual = dino.send(field)).nil?
				compare(field, actual.downcase, value.downcase) > 0
			}
		)
	end

	def lte( field, value  )
		Dinodex.new(
			@dinos.select{ |dino|
				next if (actual = dino.send(field)).nil?
				compare(field, actual.downcase, value.downcase) <= 0
			}
		)
	end

	def gte( field, value  )
		Dinodex.new(
			@dinos.select{ |dino|
				next if (actual = dino.send(field)).nil?
				compare(field, actual.downcase, value.downcase) >= 0
			}
		)
	end

	def neq( field, value  )
		Dinodex.new(
			@dinos.select{ |dino|
				next if (actual = dino.send(field)).nil?
				compare(field, actual.downcase, value.downcase) != 0
			}
		)
	end

	def eq( field, value  )
		Dinodex.new(
			@dinos.select{ |dino|
				next if (actual = dino.send(field)).nil?
				compare(field, actual.downcase, value.downcase) == 0
			}
		)
	end

	def like( field, value  )
		Dinodex.new(
			@dinos.select{ |dino|
				next if (actual = dino.send(field)).nil?
				actual.downcase =~ /#{value.downcase}/
			}
		)
	end

	def search( hash )
		hash.inject(self){ |ddex, pair|
			ddex.eq( pair[0], pair[1] )
		}
	end

	def sort( field )
		@dinos.sort!{ |a, b|
			compare(field, a.send(field), b.send(field))
		}
		self
	end

	def json
		{
			'dinos' => @dinos.map{ |dino| dino.to_h }
		}.to_json
	end

	def inspect
		dinos.inspect
	end
end

class Dinoparse
	attr_reader :dinos

	def initialize( dinofile )
		dino_data = parse( dinofile )
		@dinos = dino_data.map{ |dino_dat| Dino.new(dino_dat) }
	end

	def parse( dinofile )
		dinos = CSV.parse( open(dinofile).read )
		keys = dinos.shift.map(&:downcase)
		dinos.map{ |dino_attrs| 
			Hash[ *keys.zip( dino_attrs ).flatten ] 
		}
	end
end

#############################################################
###################      TESTS      #########################
#############################################################

# SETUP
file1 = 'dinodex.csv'
file2 = 'african_dinosaur_export.csv'

dinos1 = Dinoparse.new( file1 ).dinos()
dinos2 = Dinoparse.new( file2 ).dinos()

dinodex = Dinodex.new( dinos1 + dinos2 ).sort('name')

# QUERIES
puts "Grab all dinosaurs that were bipeds"
puts "-"*20
dinodex.eq('walking', 'biped').index()
puts

puts "Grab all the dinosaurs that were carnivores (fish and insects count)"
puts "-"*20
dinodex.neq('diet', 'herbivore').index()
puts

puts "Grab dinosaurs for specific periods (no need to\
  differentiate between early and late cretaceous, btw.)"
puts "-"*20
dinodex.like('period', 'cretaceous').index()
puts


puts "Grab only big (> 2 tons) or small dinosaurs."
puts "-"*20
dinodex.gt('weight', '4000').index()
puts

puts "Just to be sure, I'd love to be able to combine criteria at will, \
 even better if I can chain filter calls together"
puts "-"*20
dinodex.like('name', 'D...o')
		.like('period', 'early')
		.like('continent', 'america').index()
puts

puts "Another example of chaining."
puts "-"*20
dinodex.like('name', 'saurus')
		.gte('weight', '10000').index()
puts

puts "I would love to have a way to do (and chain) generic\
 search by parameters. I can pass in a hash, and I'd like to\
  get the proper list of dinos back out."
puts "-"*20
dinodex.search({'diet'=> 'carnivore', 'continent'=>'europe'}).index()
puts

puts "CSV isn't may favorite format in the world. Can\
 you implement a JSON export feature?"
puts "-"*20
puts dinodex.json()
puts

#DONE