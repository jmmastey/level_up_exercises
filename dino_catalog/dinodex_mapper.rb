require 'csv'
require_relative 'dinosaur'

class DinoDexMapper

  def map_dinos(entry)
    #eintry["NAME"] == "Abrichtosaurus"
    dinosaur = Dinosaur.new()
    dinosaur.name = entry["NAME"]
    dinosaur.period = entry["PERIOD"]
    dinosaur.continent = entry["CONTINENT"] 
    dinosaur.diet = entry["DIET"]
    dinosaur.weight = entry["WEIGHT_IN_LBS"]
    dinosaur.walking = entry["WALKING"]
    dinosaur.description = entry["DESCRIPTION"]
    dinosaur
  end
end
