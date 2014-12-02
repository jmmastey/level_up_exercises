require_relative 'query_chainer.rb'
require_relative 'dino_data_parse.rb'

class DinoDex
  attr_accessor :dinosaurs

  def initialize
    @dinosaurs =  DinoDataParser.new.parse('dinodex.csv')
    @dinosaurs += DinoDataParser.new.parse_african('african_dinosaur_export.csv')
  end

  def all
    QueryChainer.new(dinosaurs)
  end

  def where(*args)
    all.where(*args)
  end

  def limit(args)
    all.limit(args)
  end

  def sort(args)
    all.sort(args)
  end

  def carnivores
    all.where(diet: %w(Carnivore Insectivore Piscivore))
  end

  def big
    all.where(weight_in_lbs: { '>=' => 1000 })
  end

  def small
    all.where(weight_in_lbs: { '<' => 1000 })
  end

  def to_json
    all.to_json
  end

  def inspect
    all.pretty
  end
end
