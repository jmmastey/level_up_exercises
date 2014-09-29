require_relative 'file_handler'
require_relative 'dinosaur'

class AfricanFile < FileHandler
  def map_to_object(content)
    dinosaur = Dinosaur.new()

    dinosaur.continent = "Africa"

    #map headers to content
    headers.zip(content).each do |field, value|
      case field.downcase
        when "genus"
          dinosaur.name = value
        when "carnivore"
          if value == 'Yes'
            dinosaur.diet = "Carnivore"
          else
            dinosaur.diet = "Herbivore"
          end
        when "weight"
          dinosaur.weight = value
          dinosaur.weight_classification = Dinosaur.determine_weight_classification(value)
        else
          dinosaur.send("#{field.downcase}=", value)
      end
    end

    dinosaur
  end
end
