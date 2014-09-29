require_relative 'file_handler'
require_relative 'dinosaur'

class DinodexFile < FileHandler
  def map_to_object(content)
    dinosaur = Dinosaur.new()

    #map headers to content
    headers.zip(content).each do |field, value|
      case field.downcase
        when "weight_in_lbs"
          dinosaur.weight = value
          dinosaur.weight_classification = Dinosaur.determine_weight_classification(value)
        else
          dinosaur.send("#{field.downcase}=", value)
      end
    end

    dinosaur
  end
end
