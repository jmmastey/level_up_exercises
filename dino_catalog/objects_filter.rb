class ObjectsFilter
  def self.filter_objects(filters, objects)
    filters.each do |operator, attributes_values|
      objects = operator_filters(objects, operator, attributes_values)
    end
    objects
  end

  def self.operator_filters(objects, operator, attributes_values)
    filter_exception unless attributes_values.class == Hash
    attributes_values.each do |attribute, value|
      objects = add_filter(objects, operator, attribute => value)
    end
    objects
  end

  def self.add_filter(objects, operator, attribute_value)
    objects.select { |object| passes_filter?(object, operator, attribute_value) }
  rescue
    filter_exception
  end

  def self.passes_filter?(object, operator, attribute_value)
    object.send("#{attribute_value.keys[0]}")
      .send(operator, attribute_value.values[0])
  end

  def self.filter_exception
    raise "Invalid filters: must contain attributes of the class in format "\
          "{ operator <string> => { attribute: value } }, "\
          "i.e. { \"==\" => { gender: \"male\", age: 45 } } "
  end
end
