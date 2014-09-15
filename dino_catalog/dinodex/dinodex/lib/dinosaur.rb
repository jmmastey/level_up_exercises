require "JSON"
class Dinosaur
  attr_accessor :name, :period, :diet, :weight, :walking, :description
  attr_accessor :continent

  def initialize(values = {})
    values.each do |key, value|
      instance_variable_set("@#{key}", value) unless value.nil?
    end
  end

  def to_json(options = nil)
    hash = instance_variables.inject({}) do |attributes, instance_var|
      attributes[instance_var] = instance_variable_get(instance_var)
      attributes
    end
    hash.to_json(options)
  end
end
