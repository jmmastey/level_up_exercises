require 'csv'
require 'set'
require './dino.rb'

class DinoParse
  attr_reader :dinos

  def initialize(dinofile)
    dino_data = parse(dinofile)
    @dinos = dino_data.map { |dino_dat| Dino.new(dino_dat) }
  end

  private

  def drop_unused_attributes(d_attrs)
    to_delete = Set.new(%w(carnivore genus weight_in_lbs))
    d_attrs.delete_if { |key, _| to_delete.member?(key) }
  end

  def consolidate(d_attrs)
    d_attrs['weight'] = d_attrs['weight_in_lbs'] || d_attrs['weight']
    d_attrs['name'] = d_attrs['name'] || d_attrs['genus']

    new_diet = (d_attrs['carnivore'] ? 'Carnivore' : "Non-Carnivore")
    d_attrs['diet'] = d_attrs['diet'] || new_diet
    d_attrs['continent'] = d_attrs['continent'] || 'Africa'

    drop_unused_attributes(d_attrs)
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
