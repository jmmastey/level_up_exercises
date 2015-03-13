class Dino
  attr_accessor :name, :period, :diet, :weight, :walking, :continent,
                :description

  SMALL_WEIGHT = 4000
  CARNIVORE_DIETS = %w(carnivore insectivore piscivore)

  def initialize(values = {})
    @name = values[:name]
    @period = values[:period]
    @diet = values[:diet]
    @weight = values[:weight]
    @walking = values[:walking]
    @continent = values[:continent]
    @description = values[:description]
  end

  def diet=(val)
    @diet = val
    @diet = "Carnivore" if val == "Yes"
    @diet = "Herbivore" if val == "No"
  end

  def match?(params)
    params.each do |param|
      return false unless match_one?(param)
    end
  end

  def match_one?(param)
    key = param[0]
    matcher = (key == "weight" || key == "diet") ? key : "other"
    send("match_#{matcher}?", param)
  end

  def match_diet?(param)
    val = param[1]
    ((val == "carnivore") && carnivore?) || (val == diet.downcase)
  end

  def match_weight?(param)
    val = param[1]
    (val == "big" && big?) || (val == "small" && small?) || (weight == val)
  end

  def match_other?(param)
    key = param[0]
    val = param[1]

    dino_val = send(key)
    dino_val.downcase.index(val)
  end

  def carnivore?
    CARNIVORE_DIETS.include?(diet.downcase)
  end

  def big?
    weight.to_i > SMALL_WEIGHT
  end

  def small?
    weight.to_i.between?(1, SMALL_WEIGHT)
  end
end
