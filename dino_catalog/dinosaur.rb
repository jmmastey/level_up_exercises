class Dinosaur
  attr_reader :period, :weight, :walking, :name
  attr_reader :carnivorous, :diet, :continent, :description

  def initialize(*facts)
    facts = facts[0]
    assign_name(facts)
    assign_weight(facts)
    assign_carnivorous_and_diet(facts)
    assign_other_facts(facts)
  end

  def assign_name(facts)
    @name = facts["name"] || facts["genus"]
  end

  def assign_weight(facts)
    @weight = facts["weight"] || facts["weight_in_lbs"]
  end

  def assign_carnivorous_and_diet(facts)
    @carnivorous = facts["diet"] == "Carnivore" || facts["Carnivore"] == "Yes"
    if @carnivorous
      @diet = "Carnivore"
    elsif facts["diet"]
      @diet = facts["diet"]
      @carnivorous = @diet == "Insectivore" || @diet == "Piscivore"
    end
  end

  def assign_other_facts(facts)
    @period = facts["period"]
    @walking = facts["walking"]
    @continent = facts["continent"]
    @description = facts["description"]
  end
end
