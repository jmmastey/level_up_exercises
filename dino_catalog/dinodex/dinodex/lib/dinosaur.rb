require "JSON"
class Dinosaur
	attr_accessor :name, :period, :diet, :weight, :walking, :description, :continent

  def to_json(options = nil)
    hash = {}
    self.instance_variables.each do |var|
      hash[var] = self.instance_variable_get var
    end
    hash.to_json(options)
  end
end