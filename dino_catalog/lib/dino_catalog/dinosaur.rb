require_relative '../dino_catalog'

module DinoCatalog
  class Dinosaur
    include DinoCatalog::DinoPrinter
    CARNIVORE_TYPES = %w(carnivore piscivore insectivore)

    ATTRIBUTES = [
      :name,
      :description,
      :walking,
      :diet,
      :period,
      :weight_in_lbs,
      :continent,
      :size,
    ]
    attr_reader *(ATTRIBUTES)

    def initialize(
      name:          nil,
      period:        nil,
      continent:     nil,
      diet:          nil,
      weight_in_lbs: nil,
      walking:       nil,
      description:   nil)

      @name	          = name
      @period	        = period
      @continent      = continent
      @diet           = diet
      @weight_in_lbs	= weight_in_lbs
      @walking	      = walking
      @description	  = description
    end

    def carnivore?
      CARNIVORE_TYPES.include?(diet.downcase)
    end

    def biped?
      walking.downcase == "biped"
    end

    def to_s
      formatted_facts
    end

    def to_h
      instance_variables.each_with_object({}) do |variable, h|
        h[variable] = instance_variable_get(variable)
      end
    end

    def big?
      calculated_size == "big"
    end

    def small?
      calculated_size == "small"
    end

    private

    def formatted_facts
      ATTRIBUTES.map do |attribute|
        value = send(attribute)
        "#{attribute}: #{value}" if value
      end.compact.join("\n")
    end

    def calculated_size
      weight = weight_in_lbs.to_i
      if weight >= 4000
        "big"
      elsif weight > 0
        "small"
      end
    end
  end
end
