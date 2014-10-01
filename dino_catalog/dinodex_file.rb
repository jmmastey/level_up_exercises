require_relative "file_handler"
require_relative "dinosaur"

class DinodexFile < FileHandler
  def map_to_object(content)
    Dinosaur.new(name: content["NAME"],
                 period: content["PERIOD"],
                 diet: content["DIET"],
                 weight: content["WEIGHT_IN_LBS"],
                 walking: content["WALKING"],
                 continent: content["CONTINENT"],
                 description: content["DESCRIPTION"],)
  end
end
