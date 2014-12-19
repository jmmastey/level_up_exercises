class ObjectsFilter

  def self.filter_objects(filters, objects)
    filters.each do |operator, attributes_values|
      objects = operator_filters(objects, operator, attributes_values)
    end
    objects
  end

  def self.operator_filters(objects, operator, attributes_values)
    if attributes_values.class != Hash
      filter_exception
    else
      attributes_values.each do |attribute, value|
        objects = add_filter(objects, operator, { attribute => value })
      end
      objects
    end
  end

  def self.add_filter(objects, operator, attribute_value)
    begin
      objects.select do |object|
        object.send("#{attribute_value.keys[0]}")
            .send(operator, attribute_value.values[0])
      end
    rescue
      filter_exception
    end
    objects
  end

  def self.filter_exception
    raise "Invalid filters: must contain attributes of the class in format { operator <string> => { attribute: value } }, i.e. { \"==\" => { gender: \"male\", age: 45 } } "
  end
end