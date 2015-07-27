class Dinosaur
  attr_reader :period, :weight, :walking, :name, :diet, :continent, :description

  def initialize(facts)
    facts.each_value { |val| val.downcase! unless val.nil? }
    assign_name(facts)
    assign_weight(facts)
    assign_diet(facts)
    assign_other_facts(facts)
  end

  def assign_name(facts)
    @name = facts["name"] || facts["genus"]
  end

  def assign_weight(facts)
    @weight = facts["weight"].to_i unless facts["weight"].nil?
    @weight = facts["weight_in_lbs"].to_i unless facts["weight_in_lbs"].nil?
  end

  def assign_diet(facts)
    @diet = "carnivore" if facts["carnivore"] == "yes"
    @diet = "herbivore" if facts["carnivore"] == "no"
    @diet = facts["diet"] if facts["diet"]
  end

  def assign_other_facts(facts)
    @period = facts["period"]
    @walking = facts["walking"]
    @continent = facts["continent"]
    @description = facts["description"]
  end

  def carnivorous?
    @diet == "carnivore" || @diet == "piscivore" || @diet == "insectivore"
  end
end
