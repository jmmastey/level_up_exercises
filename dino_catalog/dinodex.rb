require 'csv'
require 'json'
require_relative 'dinosaur.rb'

class DinoDex	
  attr_reader :dinosaurs

  def initialize (dinosaurs = nil)
    @dinosaurs = dinosaurs || []
  end

  def count (*args)
    @dinosaurs.count *args
  end

  def each (*args)
    @dinosaurs.each *args
  end

  def find (params)
    params = params.to_h
    dinos = @dinosaurs

    params.each do |key , value|
      dinos = dinos.select do |dinosaur|
        variable_name = "@#{key}"
        !dinosaur.instance_variable_defined?(variable_name) || 
          dinosaur.instance_variable_get(variable_name) == value
      end
    end

    dinos
  end

  def find_albian
    dinos = @dinosaurs.select do |dinosaur| 
      dinosaur.period.to_str.downcase == "albian"
    end

    DinoDex.new dinos
  end

  def find_big
    dinos = @dinosaurs.select do |dinosaur| 
      (dinosaur.weight || 0) > 2000
    end 

    DinoDex.new dinos
  end

  def find_bipeds
    dinos = @dinosaurs.select do |dinosaur|
      dinosaur.walking.to_str.downcase == "biped"
    end 

    DinoDex.new dinos
  end

  def find_carnivores
    dinos = @dinosaurs.select do |dinosaur| 
      ["carnivore", "insectivore", "piscivore"].include? \
        dinosaur.diet.to_str.downcase
    end

    DinoDex.new dinos
  end

  def find_cretaceous
    dinos = @dinosaurs.select do |dinosaur|
      dinosaur.period.to_str.downcase.include? "cretaceous"
    end

    DinoDex.new dinos
  end

  def find_jurassic
    dinos = @dinosaurs.select do |dinosaur|
      dinosaur.period.to_str.downcase == "jurassic"
    end

    DinoDex.new dinos
  end

  def find_oxfordian
    dinos = @dinosaurs.select do |dinosaur|
      dinosaur.period.to_str.downcase == "oxfordian"
    end

    DinoDex.new dinos
  end

  def find_permian
    dinos = @dinosaurs.select do |dinosaur|
      dinosaur.period.to_str.downcase == "permian"
    end

    DinoDex.new dinos
  end

  def find_triassic
    dinos = @dinosaurs.select do |dinosaur|
      dinosaur.period.to_str.downcase == "triassic"
    end

    DinoDex.new dinos
  end

  def load_csv (file_path)
    return false unless File.exists?(file_path) && File.readable?(file_path)

    @index ||= []

    csv = CSV.read file_path, :headers => true,
      :return_headers => true,
      :header_converters => :downcase
    csv.each { |row| @dinosaurs << csv_parse_row(row) }

    @dinosaurs
  end

  def to_json (*args)
    @dinosaurs.to_json *args
  end

  def to_s
    str = ""
    self.dinosaurs.each do |dino|
      str << dino.to_s << "\n"
    end

    str
  end

  protected
  def csv_parse_row (row)
    dinosaur = Dinosaur.new

    row.each do |header , field|
      case header
      when "name"
        dinosaur.name = field
      when "genus"
        dinosaur.name = field
      when "period"
        dinosaur.period = field
      when "continent"
        dinosaur.continent = field
      when "diet"
        dinosaur.diet = field
      when "carnivore"
        if field
          if field.downcase == "yes"
            dinosaur.diet = "Carnivore"
          else
            dinosaur.diet = "Herbivore"
          end #if
        end #if
      when "walking"
        dinosaur.walking = field
      when "description"
        dinosaur.description = field
      else
        if header.include? "weight"
          dinosaur.weight = field.to_i
        end
      end #case
    end #each

    dinosaur
  end
end

