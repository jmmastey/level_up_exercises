require_relative 'query_chainer.rb'
require_relative 'dino_data_parse.rb'

class DinoDex
  attr_accessor :dinosaurs

  def initialize
    @dinosaurs =  DinoDataParser.parse('dinodex.csv')
    @dinosaurs += DinoDataParser.parse_african('african_dinosaur_export.csv')
  end

  def all
    QueryChainer.new(dinosaurs)
  end

  def where(*args)
    QueryChainer.new(dinosaurs).where(*args)
  end

  def limit(args)
    QueryChainer.new(dinosaurs).limit(args)
  end

  def sort(args)
    QueryChainer.new(dinosaurs).sort(args)
  end

  def carnivores
    QueryChainer.new(dinosaurs).where(diet: %w(Carnivore Insectivore Piscivore))
  end

  def big
    QueryChainer.new(dinosaurs).where(weight_in_lbs: { '>=' => 1000 })
  end

  def small
    QueryChainer.new(dinosaurs).where(weight_in_lbs: { '<' => 1000 })
  end

  def to_json
    all.to_json
  end

  def inspect
    all.pretty
  end
end
