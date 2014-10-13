# Diet
#
# Objects that represent the various specific types of diets that dinosaurs can have.
class Dinodex::Diet
  
  attr_reader :diet           # What such a diet is called

  def initialize(diet_name, is_carnivore)
    @diet, @carnivorous = diet_name, is_carnivore
  end

  def carnivorous?
    @carnivorous
  end

  INSECTIVORE               = new("insectivore", true)
  PISCIVORE                 = new("piscivore", true)
  CARNIVORE                 = new("carnivore", true)
  UNSPECIFIED_CARNIVORE     = new("unspecified carnivore", true)
  UNSPECIFIED_NONCARNIVORE  = new("unspecified non-carnivore", false)
end
