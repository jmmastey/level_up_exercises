require 'csv'
require_relative 'dinosaur'
class DinoDexMapper
  def map_dinos(entry)
    Dinosaur.new(
    name: entry['NAME'],
    period: entry['PERIOD'],
    continent: entry['CONTINENT'],
    diet: entry['DIET'],
    weight: entry['WEIGHT_IN_LBS'],
    walking: entry['WALKING'],
    description: entry['DESCRIPTION'])
  end
end
