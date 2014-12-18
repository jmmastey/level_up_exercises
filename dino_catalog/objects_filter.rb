class ObjectsFilter

  def self.filter_objects(filters, objects)
    filters.each do |operator, attributes_values|
      objects = operator_filters(objects, operator, attributes_values)
    end
    objects
  end

  def self.operator_filters(objects, operator, attributes_values)
    attributes_values.each do |attribute, value|
      objects = add_filter(objects, operator, { attribute => value })
    end
    objects
  end

  def self.add_filter(objects, operator, attribute_value)
    objects.select do |object|
      object.send("#{attribute_value.keys[0]}")
          .send(operator, attribute_value.values[0])
    end
    objects
  end
end