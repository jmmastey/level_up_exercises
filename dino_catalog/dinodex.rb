require_relative 'query_chainer.rb'
require_relative 'dino_data_parse.rb'

class DinoDex
  extend Forwardable
  attr_accessor :dinosaurs
  delegate [:sort, :where, :limit, :to_json] => :all

  def initialize
    @dinosaurs =  DinoDataParser.new.parse('dinodex.csv')
    @dinosaurs += DinoDataParser.new.parse_african('african_dinosaur_export.csv')
  end

  def all
    QueryChainer.new(dinosaurs)
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
end
