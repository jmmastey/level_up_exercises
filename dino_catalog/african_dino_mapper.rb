require 'csv'
require_relative 'dinosaur'

class AfricanDinoMapper

  def map_dinos(entry)
    Dinosaur.new(
    name: entry['Genus'],
    period: entry['Period'],
    continent: 'Africa',
    diet: which_diet(entry['Carnivore']),
    weight: entry['Weight'],
    walking: entry['Walking'])
  end

  x = []

  def which_diet(x)
    if x == 'Yes'
        'Carnivore'
    else
        'Herbivore'
    end
  end
end
