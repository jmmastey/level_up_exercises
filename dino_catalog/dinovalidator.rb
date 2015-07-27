InvalidDataError = Class.new(RuntimeError)

class String
  def alpha?
    match(/^[a-z ]*$/) != nil
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

  def self.valid_row?(row)
    row.reduce(0) do |valid, (k, v)|
      valid && DISPATCHER.include?(k) ? DISPATCHER[k].call(v) : true
    end
  end

  def self.valid_data?(data)
    data.reduce(0) { |valid, row| valid && valid_row?(row) }
  end
end
