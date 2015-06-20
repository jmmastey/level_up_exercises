class Dinosaur
  attr_accessor :genus, :weight, :walking, :continent, :description, :carnivore,
    :diet_details, :period
  def initialize(dinosaur)
    @genus = dinosaur[:genus]
    @weight = dinosaur[:weight]
    @walking = dinosaur[:walking]
    @continent = dinosaur[:continent]
    @description = dinosaur[:description]
    @diet_details = dinosaur[:diet_details]
    @carnivore = dinosaur[:carnivore]
    @period = dinosaur[:period]
  end

  def to_s
    result = "Dino Details:"
    if !genus.nil?
      result += "\nGenus: " + genus
    end

    if !period.empty?
      result += "\nPeriod: "
      period_string = period.map{|p| [p[:modifier].to_s, p[:period]].join(" ")}.join(" or ")
      result += period_string
    end

    if !description.nil?
      result += "\nDescription: " + description
    end

    if !weight.nil?
      result += "\nWeight: " + weight
    end

    if !walking.nil?
      result += "\nWalking: " + walking
    end

    if !continent.nil?
      result += "\nContinent: " + continent
    end

    if !carnivore.nil?
      result += "\nCarnivore: " + carnivore
    end

    if !diet_details.nil?
      result += "\nDiet Details: " + diet_details
    end

    result
  end
end
