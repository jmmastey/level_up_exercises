require 'active_support/all'

class Dinosaur
  attr_accessor :name, :period, :continent, :diet, :walking, :description

  def initialize(options)
    options.each{ |key, value| send("#{key} = ", value) }
  end

  def weight_in_lbs=(weight_in_lbs)
    @weight_in_lbs = weight_in_lbs.to_i
  end

  def weight_in_lbs
    @weight_in_lbs
  end

  def carnivore?
    @carnivore = carnivores.include?(@diet) ? true : false
  end

  def period_type
    @period_type = period_period_types[@period]
  end

  def print_dinosaur_info
    instance_variables.each do |attr_name|
      attr_value = instance_variable_get attr_name
      unless attr_value.nil?
        puts "#{attr_name.to_s.sub('@', '').titleize}: #{attr_value}"
      end
    end
  end

  private

    def carnivores
      ["Carnivore", "Insectivore", "Piscivore"]
    end

    def period_period_types
      { "Early Cretaceous" => "Cretaceous",
        "Late Cretaceous" => "Cretaceous",
        "Cretaceous" => "Cretaceous",
        "Jurassic" => "Jurassic",
        "Oxfordian" => "Oxfordian"}
    end
end
