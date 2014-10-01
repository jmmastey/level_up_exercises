require 'csv'
require_relative 'dinosaur'
# Class to map the african_dino.csv
class AfricanDinoMapper
  def carnivore(value)
    if value == 'Yes'
      'Carnivore'
    elsif value == 'No'
      'Herbivore'
    end
  end

  def map_dinos(entry)
    dinosaur = Dinosaur.new
    dinosaur.name = entry['Genus']
    dinosaur.period = entry['Period']
    dinosaur.continent = 'Africa'
    dinosaur.diet = carnivore(entry['Carnivore'])
    dinosaur.weight = entry['Weight']
    dinosaur.walking = entry['Walking']
    dinosaur
  end
end
