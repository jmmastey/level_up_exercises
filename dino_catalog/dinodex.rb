require 'json'
require_relative 'dinosaur'
require_relative 'dinoparser'
require_relative 'dinovalidator'
require_relative 'dinouniformer'
require_relative 'dinodex_printer'

class Dinodex
  attr_accessor :registry, :loaded_files

  search_name = ->(res, name) {
    res.select { |dino| dino.named?(name) }
  }

  search_period = ->(res, period) {
    res.select { |dino| dino.period?(period) }
  }

  search_diet = ->(res, diet) {
    res.select { |dino| dino.diet?(diet) }
  }

  search_big = ->(res, search) {
    res.select { |dino| dino.big? if search }
  }

  search_small = ->(res, search) {
    res.select { |dino| dino.small? if search }
  }

  search_weight = ->(res, weight) {
    res.select { |dino| dino.weighs?(weight) }
  }

  search_walking = ->(res, walking) {
    res.select { |dino| dino.walking?(walking) }
  }

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
    @dinoparser = DinoParser.new
    @dinovalidator = DinoValidator.new
    @dinouniformer = DinoUniformer.new
    @dinodex_printer = DinodexPrinter.new
  end

  def build_registry(data)
    @registry |= data.map { |row| Dinosaur.new(row) }
  end

  def load_csv(filename)
    return unless File.file?(filename)
    data = @dinouniformer.uniform(@dinoparser.parse_csv(filename))
    raise InvalidDataError unless @dinovalidator.valid_data?(data)
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
    @dinodex_printer.print(results)
  end

  def export_json(results = @registry)
    { "dinosaurs" => results.map(&:data) }.to_json
  end

  def to_s(subset = @registry)
    @dinodex_printer.print(subset)
  end
end
