require_relative "file_handler"
require_relative "dinosaur"

class AfricanFile < FileHandler
  def map_to_object(content)
    Dinosaur.new(name: content["Genus"],
                 period: content["Period"],
                 diet: is_carnivore(content["Carnivore"]),
                 weight: content["Weight"],
                 walking: content["Walking"],
                 continent: "Africa",)
  end

  def is_carnivore(carnivore)
    if carnivore == "Yes"
      "Carnivore"
    else
      "Herbivore"
    end
  end
end
