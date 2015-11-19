class DinoCatalog::Dinosaur
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
  attr_reader *ATTRIBUTES

  def initialize(
    name: nil,
    period:        nil,
    continent:     nil,
    diet:          nil,
    weight_in_lbs: nil,
    walking:       nil,
    size:          nil,
    description:   nil)

    @name	= name
    @period	= period
    @continent	= continent
    @diet	= diet
    @weight_in_lbs	= weight_in_lbs
    @size	= calculated_size(weight_in_lbs.to_i)
    @walking	= walking
    @description	= description
  end

  def print_facts
    puts formatted_facts
  end

  def to_json
    json_hash = {}
    instance_variables.each do |variable|
      json_hash[variable] = instance_variable_get(variable)
    end
    json_hash.to_json
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
