# Diet
#
# Objects that represent the various specific types of diets that dinosaurs can have.
class Dinodex::Diet < TokenSelectable
  alias_method :diet, :name           # What such a diet is called

  def initialize(diet_name, is_carnivore, token_pattern)
    super(diet_name, token_pattern)
    @carnivorous = is_carnivore
  end

  def carnivorous?
    @carnivorous
  end

  @all_instances = [
    INSECTIVORE               = new("insectivore", true, /insect/i),
    PISCIVORE                 = new("piscivore", true, /pisc/i),
    CARNIVORE                 = new("carnivore", true, /^carn/i),
    HERBIVORE                 = new("herbivore", true, /herb/i),
    UNSPECIFIED_CARNIVORE     = new("unspecified carnivore", true, /carn/i),
    UNSPECIFIED_NONCARNIVORE  = new("unspecified non-carnivore", 
                                    false, /non-?carn/i),
  ]
end
