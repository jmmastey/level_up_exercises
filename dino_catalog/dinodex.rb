require 'csv'
require 'pp'
require_relative 'dino.rb'
require_relative 'dino_converters.rb'

class Dinodex
  def initialize(array_of_dinos = [])
    @dinos = array_of_dinos
  end

  def load (file)
    csv = CSV.new(File.read(file), 
                  headers: true, 
                  header_converters: [:african_converter, :weight_converter, :symbol], 
                  converters: [:african_diet_converter, :all, :nil_or_downcase]) 
    @dinos.concat(csv.to_a.map { |row| Dino.new(row.to_hash) })
  end

  def biped
    select_from_dinos_where("biped")
  end
  
  def carnivore
    select_from_dinos_where("carnivore")
  end

  def giant
    select_from_dinos_where("giant")
  end

  def from(periods)
    select_from_dinos_where("from", periods)
  end

  def to_s
    @dinos.map { |dino| dino.to_s + "\n" + "---------------------------------" }.join("\n")
  end

  private
  def select_from_dinos_where(method, *args)
    Dinodex.new(@dinos.select { |dino| dino.send("#{method}?", *args) })
  end
  
end
