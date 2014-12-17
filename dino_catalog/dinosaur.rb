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
    attributes.each { |key, value| send("#{key}=", value) }
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

  def print_dinosaur_info
    instance_variables.each do |attr_name|
      attr_value = instance_variable_get attr_name
      unless attr_value.nil?
        puts "#{attr_name.to_s.sub('@', '').titleize}: #{attr_value}"
      end
    end
  end
end
