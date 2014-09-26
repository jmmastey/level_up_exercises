# Sample headers: NAME,PERIOD,CONTINENT,DIET,WEIGHT_IN_LBS,WALKING,DESCRIPTION
# Sample content: Quetzalcoatlus,Late Cretaceous,North America,Carnivore,440,Quadruped,Largest known flying animal of all time.
require_relative 'file_handler'
require_relative 'dinosaur'

class DinodexFile < FileHandler
  def get_all_dinosaurs()
    dinosaurs = []

    #loop through content
    contents.each do |content|
      dinosaurs << map_to_dinosaur(content)
    end

    dinosaurs
  end

  def map_to_dinosaur(content)
    dinosaur = Dinosaur.new()

    #map headers to content
    headers.zip(content).each do |field, value|
      case field.downcase
        when 'weight_in_lbs'
          dinosaur.weight = value
        else
          dinosaur.send("#{field.downcase}=", value)
      end
    end

    dinosaur
  end
end