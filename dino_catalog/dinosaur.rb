require_relative 'filterable'

class Dinosaur
  include Filterable
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

  def diet
    return 'Carnivore' if @diet =~ /Insect|Pisci|Yes/i
    @diet
  end

  def to_h
    instance_variables.each_with_object({}) do |variable, attributes|
      attributes[variable.to_s.delete('@')] = instance_variable_get(variable)
    end
  end

  private

  def map_keys(key)
    return KEY_MAPS[key.to_sym] if KEY_MAPS.key?(key.to_sym)
    key
  end
end
