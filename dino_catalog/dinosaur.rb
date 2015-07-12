require_relative('filterable')
class Dinosaur < Filterable
  attr_accessor :name, :period, :continent, :diet, :weight,
                :walking, :description

  KEY_MAPS = {
    genus: 'name',
    carnivore: 'diet',
    weight_in_lbs: 'weight',
  }

  def initialize(args)
    args.each do |key, value|
      key = map_keys(key)
      next unless self.respond_to?(key)
      instance_variable_set("@#{key}", value) unless value.nil?
    end
  end

  def diet=(value)
    value = 'Carnivore' if value =~ /Insect|Pisci|Yes/
    write_attribute(:diet, value)
  end

  def to_hash
    attributes = {}
    instance_variables.each do |variable|
      attributes[variable.to_s.delete('@')] = instance_variable_get(variable)
    end
    attributes
  end

  private

  def map_keys(key)
    return KEY_MAPS[key.to_sym] if KEY_MAPS.member?(key.to_sym)
    key
  end
end
