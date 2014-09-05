require 'json'
require_relative 'trace.rb'

class Dinosaur
  attr_accessor :name, :period, :continent, :diet, :weight, :walking, :description

  @@labels = {
    name: "Name",
    period: "Period",
    continent: "Continent",
    diet: "Diet",
    weight: "Weight (in lbs)",
    walking: "Walking",
    description: "Description"
  }

  def initialize (fields = {})
    init_field_maps
    map_fields fields
  end
  
  def carnivore?
    diet_lower_case = diet.downcase

    diet_lower_case == "carnivore" ||
      diet_lower_case == "insectivore" ||
      diet_lower_case == "piscavore"
  end

  def match? (args)
    args.all? do |key, value|
      var_name = "@#{key}"

      instance_variable_defined?(var_name) &&
        instance_variable_get(var_name).to_s.downcase == value.to_s.downcase
    end
  end

  def match_partial? (args)
    args.all? do |key, value|
      var_name = "@#{key}"

      instance_variable_defined?(var_name) &&
        instance_variable_get(var_name).to_s.downcase.include?(value.to_s.downcase)
    end
  end

  def to_h
    hash = {
      name: self.name,
      period: self.period,
      continent: self.continent,
      diet: self.diet,
      weight: self.weight,
      walking: self.walking, 
      description: self.description
    }

    hash.reject { |key , value| value.nil?}
  end

  def to_json (*args)
    self.to_h.to_json *args
  end

  def to_s
    str = ""
    self.to_h.each do |key, value|
      str << @@labels[key] << ": " << value.to_s << "\n"
    end

    str
  end

  private
  def init_field_maps
    @field_maps = {
      name: :name,
      genus: :name,
      period: :period,
      continent: :continent,
      diet: :diet,
      weight: :weight,
      weight_in_lbs: :weight,
      walking: :walking,
      description: :description,
      carnivore: lambda do |field|
        if field.downcase == "yes"
          self.diet = "Carnivore"
        else 
          self.diet = "Herbivore"
        end
      end
    }
  end

  def map_fields (fields)
    fields.each do |key, value|
      field_map = @field_maps[key.to_sym]
      if field_map.nil?
        Trace["Unable to find map for #{key}."]
      elsif field_map.is_a? Symbol
        send("#{field_map}=", value)
        # instance_variable_set("@#{field_map}", value)
      else
        field_map.call value
      end
    end
  end
end
