require 'json'

class Dinosaur
  attr_accessor :name, :period, :continent, :diet, :weight_in_lbs, :walking,
    :description

  def initialize(dino)
    @name          = dino[:name]
    @period        = dino[:period]
    @continent     = dino[:continent]
    @diet          = dino[:diet]
    @weight_in_lbs = dino[:weight_in_lbs] ? dino[:weight_in_lbs].to_i : nil
    @walking       = dino[:walking]
    @description   = dino[:description]
  end

  def to_h
    instance_variables.inject({}) do |hash, var|
      hash[var.to_s.delete("@").to_sym] = instance_variable_get(var)
      hash
    end
  end

  def to_json
    to_h.to_json
  end
end
