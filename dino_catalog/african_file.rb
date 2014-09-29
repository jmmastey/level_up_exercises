require_relative 'file_handler'
require_relative 'dinosaur'

#Sample headers: Genus,Period,Carnivore,Weight,Walking
#Sample content: Melanorosaurus,Triassic,No,2400,Quadruped

class AfricanFile < FileHandler
  def map_to_object(content)
    dinosaur = Dinosaur.new()

    dinosaur.continent = 'Africa'

    #map headers to content
    headers.zip(content).each do |field, value|
      case field.downcase
        when 'genus'
          dinosaur.name = value
        when 'carnivore'
          if value == 'Yes'
            dinosaur.diet = 'Carnivore'
          else
            dinosaur.diet = 'Herbivore'
          end
        else
          dinosaur.send("#{field.downcase}=", value)
      end
    end

    dinosaur
  end
end