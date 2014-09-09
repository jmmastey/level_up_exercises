require "json"

module JSONable
  def to_json(opts = {})
    simple_object = {}
    members = self.instance_variables.map do |name|
      value = self.instance_variable_get(name)
      json_name = name.to_s.gsub("@","")
      simple_object[json_name] = value
    end
    simple_object.to_json
  end
end
