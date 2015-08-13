require_relative 'dino_csv_cleaner'
require_relative 'hash'
require_relative 'dinosaur'
require 'json'

class DinosaurSearch
  def initialize(dinos)
    @searched_dino = dinos
    init_arrays
  end

  def init_arrays
    file_array = []
    ARGV.map { |a| file_array << a }
    @dino_hash = DinoCsvCleaner.new(file_array)
    @dino_hash.create_dinosaur_hash
    @new_csv = read_new_csv
    @all_dinos = create_dino_object
  end

  def read_new_csv
    keys = open("new.csv")
    csv = CSV.new(keys, headers: true, header_converters: :symbol, converters: :all)
    csv = csv.to_a.map(&:to_hash)
    csv
  end

  def create_dino_object(all_dinos = [])
    @new_csv.each do |d|
      dino = Dinosaur.new
      dino.create_attribute(@dino_hash.csv_headers)
      d.each { |k, _| dino.send("#{k}=", d[k]) }
      all_dinos << dino
    end
    all_dinos
  end

  def biped
    dinos = []
    @all_dinos.each do |dino|
      dinos << (dino.name || dino.genus) if dino.walking == "Biped"
    end
    @searched_dino << dinos
    DinosaurSearch.new(@searched_dino)
  end

  def small
    dinos = []
    @all_dinos.each do |dino|
      dinos << (dino.name || dino.genus) if dino.weight && dino.weight < 2000
    end
    @searched_dino << dinos
    DinosaurSearch.new(@searched_dino)
  end

  def big
    dinos = []
    @all_dinos.each do |dino|
      dinos << (dino.name || dino.genus) if dino.weight && dino.weight > 2000
    end
    @searched_dino << dinos
    DinosaurSearch.new(@searched_dino)
  end

  def print_dino
    @searched_dino.last
  end

  def print_dino_object(dino, str)
    dino.instance_variables.each do |v|
      dino_var = dino.instance_variable_get("#{v}")
      str += "#{v}: " + "#{dino_var}\n" if dino_var
    end
    str
  end

  def print_dino_facts(name)
    str = ""
    @all_dinos.next do |d|
      str = print_dino_object(dino, str) if d.name == name || d.genus == name
    end
    str
  end

  def search_for(filter = {}, dinos = [])
    filter.each_pair do |k, v|
      @all_dinos.each do |dino|
        dinos << (dino.name || dino.genus) if dino.send("#{k}") == v
      end
    end
    @searched_dino << dinos
    DinosaurSearch.new(@searched_dino)
  end
end
# dino = DinosaurSearch.new([])
# pp dino.big.biped.print_dino
# pp dino.biped.big.print_dino
# pp dino.search_for({:period=>"Cretaceous"}).search_for({:diet=>"Insectivore"}).print_dino
# pp dino.search_for({:period=>"Cretaceous"}).search_for({:diet=>"Carnivore"}).print_dino
# puts dino.print_dino_facts("Albertonykus")
