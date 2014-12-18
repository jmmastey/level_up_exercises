require 'active_support/all'

class Dinosaur
  attr_accessor :name, :period, :continent, :diet, :walking, :description, :weight_in_lbs
  CARNIVORES = %w(Carnivore Insectivore Piscivore)
  PERIOD_PERIOD_TYPES =
  { "Early Cretaceous" => "Cretaceous",
    "Late Cretaceous" => "Cretaceous",
    "Cretaceous" => "Cretaceous",
    "Jurassic" => "Jurassic",
    "Oxfordian" => "Oxfordian" }

  def initialize(attributes = {})
    begin
      attributes.each { |key, value| send("#{key}=", value) }
    rescue
      raise "Invalid attributes hash: must contain attributes of Dinosaur class in format { operator <string> => { attribute: value } }"
    end
  end

  def weight_in_lbs=(weight_in_lbs)
    @weight_in_lbs = weight_in_lbs.to_i
  end

  def carnivore?
    CARNIVORES.include?(@diet)
  end

  def period_type
    @period_type = PERIOD_PERIOD_TYPES[@period]
  end

  def to_s
    to_s = ""
    instance_variables.each do |attr_name|
      attr_value = instance_variable_get attr_name
      unless attr_value.nil?
        to_s += "#{attr_name.to_s.sub('@', '').titleize}: #{attr_value}\n"
      end
    end
    to_s
  end
end
