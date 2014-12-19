require 'active_support/all'

class Dinosaur
  attr_accessor :name, :period, :continent, :diet, :walking, :description, :weight
  CARNIVORES = %w(Carnivore Insectivore Piscivore)
  PERIOD_TYPE_MAPPING = {
    "Early Cretaceous" => "Cretaceous",
    "Late Cretaceous" => "Cretaceous",
    "Cretaceous" => "Cretaceous",
    "Jurassic" => "Jurassic",
    "Oxfordian" => "Oxfordian",
  }

  def initialize(attributes = {})
    self.name = ""
    self.period = ""
    self.continent = ""
    self.diet = ""
    self.walking = ""
    self.description = ""
    self.weight = 0
    assign_attributes(attributes)
  end

  def assign_attributes(attributes)
    attributes.each { |key, value| send("#{key}=", value) }
  rescue
    raise "Invalid attributes hash: must contain attributes "\
          "of Dinosaur class in format { attribute: value }"
  end

  def weight=(new_weight)
    @weight = new_weight.to_i
  end

  def carnivore?
    CARNIVORES.include?(diet)
  end

  def period_type
    PERIOD_TYPE_MAPPING[period]
  end

  def to_s
    instance_variables.map { |name| map_variables(name) }.join("")
  end

  def map_variables(name)
    value = instance_variable_get(name)
    printable?(value) ? format_line(name, value) : ""
  end

  def printable?(value)
    true unless value.nil? || value == 0 || value == ""
  end

  def format_variable(name)
    name.to_s.sub("@", "").titleize
  end

  def format_line(name, value)
    "#{format_variable(name)}: #{value}\n"
  end
end
