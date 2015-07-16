class Dinosaur
  attr_reader :period, :weight, :walking, :name, :diet, :continent, :description

  def initialize(facts)
    assign_name(facts)
    assign_weight(facts)
    assign_diet(facts)
    assign_other_facts(facts)
  end

  def assign_name(facts)
    @name = facts["name"] || facts["genus"]
  end

  def assign_weight(facts)
    @weight = facts["weight"] || facts["weight_in_lbs"]
  end

  def assign_diet(facts)
    @diet = "Carnivore" if facts["Carnivore"] == "Yes"
    @diet = "Herbivore" if facts["Carnivore"] == "No"
    @diet = facts["diet"] if facts["diet"]
  end

  def assign_other_facts(facts)
    @period = facts["period"]
    @walking = facts["walking"]
    @continent = facts["continent"]
    @description = facts["description"]
  end

  def carnivorous?
    @diet == "Carnivore" || @diet == "Piscivore" || @diet == "Insectivore"
  end
end
