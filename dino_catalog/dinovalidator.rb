InvalidDataError = Class.new(RuntimeError)

class String
  def alpha?
    match(/^[A-Za-z ]*$/) != nil
  end

  def number?
    true if Float(self) rescue false
  end
end

module DinoValidator
  valid_name = -> name { name.alpha? }
  valid_period = -> period { period.alpha? }
  valid_continent = -> continent { continent.alpha? }
  valid_diet = -> diet { diet.alpha? }
  valid_weight = -> weight { weight.number? || weight.length == 0 }
  valid_walking = -> walking { walking.alpha? }

  DISPATCHER = {
    "name" => valid_name,
    "period" => valid_period,
    "continent" => valid_continent,
    "diet" => valid_diet,
    "weight" => valid_weight,
    "walking" => valid_walking,
  }

  def self.valid?(dino_attr, value)
    return true unless DISPATCHER.include?(dino_attr)
    DISPATCHER[dino_attr].call(value)
  end

  def self.valid_row?(row)
    row.all? { |dino_attr, value| valid?(dino_attr, value) }
  end

  def self.valid_data?(data)
    data.all? { |row| valid_row?(row) }
  end
end
