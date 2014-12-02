require 'json'

class Dinosaur
  attr_accessor :name, :period, :continent, :diet, :weight_in_lbs, :walking,
    :description

  def initialize(dino_hash)
    @name          = dino_hash[:name]
    @period        = dino_hash[:period]
    @continent     = dino_hash[:continent]
    @diet          = dino_hash[:diet]
    @weight_in_lbs = dino_hash[:weight_in_lbs].to_i if dino_hash[:weight_in_lbs]
    @walking       = dino_hash[:walking]
    @description   = dino_hash[:description]
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
