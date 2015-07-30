require 'json'
require_relative 'dinosaur'
require_relative 'dinoparser'
require_relative 'dinovalidator'
require_relative 'dinouniformer'
require_relative 'dinodex_printer'

class Dinodex
  attr_accessor :registry, :loaded_files

  search_name = lambda do |res, name|
    res.select { |dino| dino.name_is?(name) }
  end

  search_period = lambda do |res, period|
    res.select { |dino| dino.from_period?(period) }
  end

  search_diet = lambda do |res, diet|
    res.select { |dino| dino.diet_is?(diet) }
  end

  search_big = lambda do |res, search|
    res.select { |dino| dino.big? if search }
  end

  search_small = lambda do |res, search|
    res.select { |dino| dino.small? if search }
  end

  search_weight = lambda do |res, weight|
    res.select { |dino| dino.weight_is?(weight) }
  end

  search_walking = lambda do |res, walking|
    res.select { |dino| dino.walking_is?(walking) }
  end

  SEARCH_DISPATCHER = {
    name: search_name,
    period: search_period,
    diet: search_diet,
    big: search_big,
    small: search_small,
    weight: search_weight,
    walking: search_walking,
  }

  def initialize
    @registry = []
    @loaded_files = []
  end

  def build_registry(data)
    @registry |= data.map { |row| Dinosaur.new(row) }
  end

  def load_csv(filename)
    return unless File.file?(filename)
    data = DinoUniformer.uniform(DinoParser.parse_csv(filename))
    raise InvalidDataError unless DinoValidator.valid_data?(data)
    build_registry(data)
    @loaded_files << filename
  end

  def search(args = {}, results = @registry)
    args.each do |dino_attr, value|
      results = SEARCH_DISPATCHER[dino_attr].call(results, value)
    end
    results
  end

  def print_search(args = {})
    results = search(args)
    DinodexPrinter.print(results)
  end

  def export_json(results = @registry)
    { "dinosaurs" => results.map(&:data) }.to_json
  end

  def to_s(subset = @registry)
    DinodexPrinter.print(subset)
  end
end
