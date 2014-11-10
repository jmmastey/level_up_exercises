require_relative 'query_chainer.rb'
require_relative 'dino_data_parse.rb'

class DinoDex
  attr_accessor :dinos

  def initialize
    @dinos =  DinoDataParser.parse('dinodex.csv')
    @dinos += DinoDataParser.parse_african('african_dinosaur_export.csv')
  end

  def all
    QueryChainer.new(dinos)
  end

  def where(*args)
    QueryChainer.new(dinos).where(*args)
  end

  def limit(args)
    QueryChainer.new(dinos).limit(args)
  end

  def sort(args)
    QueryChainer.new(dinos).sort(args)
  end

  def carnivores
    QueryChainer.new(dinos).where(diet: %w(Carnivore Insectivore Piscivore))
  end

  def big
    QueryChainer.new(dinos).where(weight_in_lbs: { '>=' => 1000 })
  end

  def small
    QueryChainer.new(dinos).where(weight_in_lbs: { '<' => 1000 })
  end

  def to_json
    all.to_json
  end

  def inspect
    all.pretty
  end
end
