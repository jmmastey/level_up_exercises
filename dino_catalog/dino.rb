class Dinosaur
  attr_accessor :name, :period, :continent, :diet, :weight_in_lbs, :walking
  attr_accessor :description, :carnivore

  def initialize(dino_hash)
    data = {}
    dino_keys = {
      name:          nil,
      period:        nil,
      continent:     nil,
      diet:          nil,
      weight_in_lbs: nil,
      walking:       nil,
      description:   nil,
    }
    keys = dino_keys.keys

    dino_hash.each do |key, val|
      data[key] = val if keys.include? key
    end

    @name          = data[:name]
    @period        = data[:period]
    @continent     = data[:continent]
    @diet          = data[:diet]
    @weight_in_lbs = data[:weight_in_lbs]
    @walking       = data[:walking]
    @description   = data[:description]
    @carnivore     = carnivore?
  end

  def to_hash
    hash = {}
    instance_variables.each do |var|
      hash[var.to_s.delete("@")] = instance_variable_get(var)
    end
    hash
  end

  def to_json
    to_hash.to_json
  end

  private

  def carnivore?
    carnivores = [
      'Carnivore', # obvs
      'Insectivore',
      'Piscivore',
    ]

    !carnivores.index(@diet).nil?
  end
end
