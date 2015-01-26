# Dinasaur Obj used by dino_cvs_data_mapper.rb

class Dinosaur
  attr_accessor :name, :period, :continent, :diet, :weight, :walking, :desc

  def to_s
    label = { name: "Name", period: "Period", continent: "Continent",
        diet: "Diet", weight: "Weight", walking: "Walk", desc: "Description"
            }

    label.keys.inject("\n") do |values, key|
      value = send(key)
      values << sprintf("%s : %15s\n", label[key], value)
    end
  end

  def to_json
    hash = {}
    instance_variables.map{ |x| hash[x.to_s.delete("@")] = instance_variable_get(x) }
    hash.to_json
  end
end
