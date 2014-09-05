require 'csv'
require 'json'
require_relative 'dinosaur.rb'

class DinoDex	
  attr_reader :dinosaurs

  def initialize (dinosaurs = [])
    @dinosaurs = dinosaurs || []
  end

  def add (fields)
    @dinosaurs.push (Dinosaur.new fields)
  end

  def clone
    DinoDex.new @dinosaurs.dup
  end

  def each (*args)
    @dinosaurs.each *args
  end

  def find (params)
    params = params.to_h

    dinos = @dinosaurs.select do |dinosaur|
      dinosaur.match? params
    end

    DinoDex.new dinos
  end

  def find! (params)
    params = params.to_h

    @dinosaurs.select! do |dinosaur|
      dinosaur.match? params
    end

    self
  end

  def find_carnivore
    dinos = @dinosaurs.select do |dinosaur|
      dinosaur.carnivore?
    end

    DinoDex.new dinos
  end

  def find_carnivore!
    @dinosaurs.select! do |dinosaur|
      dinosaur.carnivore?
    end

    self
  end

  def find_with_min_weight (min_weight)
    dinos = @dinosaurs.select do |dinosaur|
      !dinosaur.weight.nil? && dinosaur.weight >= min_weight
    end

    DinoDex.new dinos
  end

  def find_with_min_weight! (min_weight)
    @dinosaurs.select! do |dinosaur|
      (dinosaur.weight || 0) >= min_weight
    end

    self
  end

  def find_with_max_weight (max_weight)
    dinos = @dinosaurs.select do |dinosaur|
      !dinosaur.weight.nil? && dinosaur.weight <= max_weight
    end

    DinoDex.new dinos
  end

  def find_with_max_weight! (max_weight)
    @dinosaurs.select! do |dinosaur|
      !dinosaur.weight.nil? && dinosaur.weight <= max_weight
    end

    self
  end

  def find_in_period (period)
    dinos = @dinosaurs.select do |dinosaur|
      dinosaur.match_partial? period: period
    end

    DinoDex.new dinos
  end

  def find_in_period! (period)
    @dinosaurs.select! do |dinosaur|
      dinosaur.match_partial? period: period
    end

    self
  end

  def load_csv (file_path)
    header_converters = [
      :downcase,
      lambda do |header|
        if header.include? "weight"
          "weight"
        else
          header
        end
      end
    ]

    weight_converter = lambda do |field, field_info|
      if field_info.header.include? "weight"
        if (field || "") == ""
          nil
        else
          field.to_i
        end
      else
        field
      end
    end

    csv = CSV.read file_path,
      headers: true,
      return_headers: true,
      header_converters: header_converters,
      converters: weight_converter

    dinos = csv.reject(&:header_row?).map { |row| Dinosaur.new row.to_hash }
    @dinosaurs.concat dinos

    self
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

  private 
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
        csv_set_carnivore field
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

  def csv_set_carnivore(field)
    if field
      if field.downcase == "yes"
        dinosaur.diet = "Carnivore"
      else
        dinosaur.diet = "Herbivore"
      end #if
    end #if
  end
end

