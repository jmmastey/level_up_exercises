require_relative 'dino_preprocessor'
require_relative 'hash'
require 'json'
require 'pp'

class DinosaurSearch
  def initialize(dinos)
    files = []
    ARGV.map { |a| files << a }
    preprocessed_dinos = DinoPreprocessor.new(files)
    @all_dinos = dinos.empty? ? preprocessed_dinos.all_dinos : dinos
  end

  def biped
    @all_dinos.select! { |dino| (dino.name || dino.genus) if dino.biped? }
    DinosaurSearch.new(@all_dinos)
  end

  def small
    @all_dinos.select! { |dino| (dino.name || dino.genus) if dino.small? }
    DinosaurSearch.new(@all_dinos)
  end

  def big
    @all_dinos.select! { |dino| (dino.name || dino.genus) if dino.big? }
    DinosaurSearch.new(@all_dinos)
  end

  def print_dino_object(dino, str)
    dino.instance_variables.each do |v|
      dino_var = dino.instance_variable_get("#{v}")
      str += "#{v}: " + "#{dino_var}\n" if dino_var
    end
    str
  end

  def print_dino_facts(attr_name, attr_val)
    str = ''
    @all_dinos.each do |d|
      obj_val = d.send("#{attr_name.to_sym}")
      str = print_dino_object(d, str) if obj_val && (obj_val.include? attr_val)
    end
    str
  end

  def search_for(filter = {})
    filter.each_pair do |k, v|
      @all_dinos.select! do |dino|
        (dino.name || dino.genus) if dino.send("#{k}").include? v
      end
    end
    DinosaurSearch.new(@all_dinos)
  end
end
dino = DinosaurSearch.new([])
# # pp dino.biped.big
# pp dino.search_for({:period=>"Cretaceous"}).search_for({:diet=>"Insectivore"})
# pp dino.search_for({:diet=>"Insectivore"}).search_for({:period=>"Cretaceous"})
# pp dino.search_for({:period=>"Cretaceous"}).search_for({:diet=>"Carnivore"})
puts dino.print_dino_facts("name", "Albertonykus")
# puts dino.print_dino_facts("diet", "Carnivore")
