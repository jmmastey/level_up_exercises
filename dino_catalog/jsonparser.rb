require "json"

module JSONable
  def to_json(_opts = {})
    simple_object = {}
    instance_variables.map do |name|
      value = instance_variable_get(name)
      json_name = name.to_s.gsub("@", "")
      simple_object[json_name] = value
    end
    simple_object.to_json
  end
end
