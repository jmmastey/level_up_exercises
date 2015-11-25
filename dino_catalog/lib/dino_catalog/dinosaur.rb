module DinoCatalog
  class Dinosaur
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
      name: nil,
      period:        nil,
      continent:     nil,
      diet:          nil,
      weight_in_lbs: nil,
      walking:       nil,
      size:          nil,
      description:   nil)

      @name	          = name
      @period	        = period
      @continent	    = continent
      @diet	          = diet
      @weight_in_lbs	= weight_in_lbs
      @size	          = calculated_size(weight_in_lbs.to_i)
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
      dino_hash = {}
      self.instance_variables.each do |variable|
        dino_hash[variable] = self.instance_variable_get(variable)
      end
      dino_hash
    end

    private

    def formatted_facts
      attributes_with_values = ATTRIBUTES.select do |attribute|
        send(attribute)
      end

      attributes_with_values.map do |attribute|
        "#{attribute}: #{send(attribute)}"
      end.join("\n")
    end

    def calculated_size(weight_in_lbs)
      if weight_in_lbs >= 2000
        "big"
      elsif weight_in_lbs > 0
        "small"
      end
    end
  end
end