require_relative 'dino_csv_cleaner'
require_relative 'hash'
require_relative 'dinosaur'
require 'json'

class DinosaurSearch
  def initialize
    @weight = nil
    file_array = []
    ARGV.each do|a|
      file_array << a
    end
    @dino_hash = DinoCsvCleaner.new(file_array)
    @dino_hash.create_dinosaur_hash
    @new_csv = read_new_csv
    @searched_dino = []
    @all_dinos = create_dino_object
  end

  def read_new_csv
    keys = open("new.csv")
    csv = CSV.new(keys, :headers => true, :header_converters => :symbol, :converters => :all)
    csv = csv.to_a.map {|row| row.to_hash }
    csv
  end

  def create_dino_object
  	all_dinos = []
  	@new_csv.each do |d|
  		dino = Dinosaur.new
  		dino.create_attribute(@dino_hash.csv_headers)
  		d.each {|k,v|
  			dino.send("#{k}=", d[k])
  		}
  		all_dinos << dino
  	end
  	all_dinos
  end

  def biped
  	dinos = []
  	@all_dinos.each do |dino|
  		if dino.walking
  			dinos << (dino.name || dino.genus) if dino.walking == "biped"
  		end
  	end
  	dinos
  end

  def small
  	dinos = []
  	@all_dinos.each do |dino|
  		if dino.weight
  			dinos << (dino.name || dino.genus) if dino.weight < 2000
  		end
  	end
  	dinos
  end

  def big
  	dinos = []
  	@all_dinos.each do |dino|
  		if dino.weight
  			dinos << (dino.name || dino.genus) if dino.weight > 2000
  		end
  	end
  	dinos
  end

  def period(dino_period)
  	dinos = []
  	@all_dinos.each do |dino|
  		if dino.period
  			dinos << (dino.name || dino.genus) if dino.include? dino_period
  		end
  	end
  	dinos
  end

  def search_for(criteria = {})
    all_dinos_array = @searched_dino
    criteria.each_pair {|k,v|
    	result = @all_dinos.select { |dino| 
    		dino.send("#{k}") == v
    	}.map{|d| d.name || d.genus}
    	@searched_dino << result
    }
    @searched_dino.flatten
  end
end

dino = DinosaurSearch.new
pp dino.biped
pp dino.search_for({:period=>"Cretaceous", :diet=>"Herbivore"})
pp dino.search_for({:diet=>"Carnivore"}).search_for({:period=>"Cretaceous"})


