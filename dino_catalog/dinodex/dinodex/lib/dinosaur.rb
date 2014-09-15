require "JSON"
class Dinosaur
  attr_accessor :name, :period, :diet, :weight, :walking, :description
  attr_accessor :continent

  def to_json(options = nil)
    hash = {}
    instance_variables.each do |var|
      hash[var] = instance_variable_get var
    end
    hash.to_json(options)
  end
end
