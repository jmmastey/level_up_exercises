require 'csv'
require 'set'
require './dino.rb'

class DinoParse
  attr_reader :dinos

  def initialize(dinofile)
    dino_data = parse(dinofile)
    @dinos = dino_data.map { |attribute_hash| Dino.new(attribute_hash) }
  end

  private

  def drop_unused_attributes(dino)
    to_delete = Set.new(%w(carnivore genus weight_in_lbs))
    dino.delete_if { |key, _| to_delete.member?(key) }
  end

  def consolidate(dino)
    dino['weight'] = dino['weight_in_lbs'] || dino['weight']
    dino['name'] = dino['name'] || dino['genus']

    new_diet = (dino['carnivore'] ? 'Carnivore' : "Non-Carnivore")
    dino['diet'] = dino['diet'] || new_diet
    dino['continent'] = dino['continent'] || 'Africa'

    drop_unused_attributes(dino)
  end

  def parse(dinofile)
    dinos = CSV.parse(open(dinofile, &:read))

    keys = dinos.shift.map(&:downcase)
    dinos.map do |dino_attrs|
      unparsed_data = Hash[keys.zip(dino_attrs)]
      consolidate(unparsed_data)
    end
  end
end
