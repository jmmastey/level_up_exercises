require './matching'

class Test
  def initialize
    @a = "hello"
    @b = [1, Object.new, nil, "hello", 4.25]
    @c = nil
    @d = true
    @e = false
  end
end

class JSONParser
  def dump_string(str)
    encoded = str.chars.map do |c|
      match(c, {
        '"' => "\"",
        "\\" => "\\\\",
        "\n" => "\\n",
        "\r" => "\\r",
        "\b" => "\\b",
        "/" => "\/",
        "\f" => "\\f",
        "\t" => "\\t",
      })
    end
    '"' + encoded.join + '"'
  end
  
  def dump(thing)
    return "null" if thing == nil
    return "false" if thing.is_a? FalseClass
    return "true" if thing.is_a? TrueClass
    return dump_fixnum(thing) if thing.is_a? Fixnum
    return dump_float(thing) if thing.is_a? Float
    return dump_string(thing) if thing.is_a? String
    return dump_array(thing) if thing.is_a? Array
    return dump_object(thing) if thing.is_a? Object
  end

  def dump_object(obj)
    variables_with_value = obj.instance_variables.map do |variable_name|
      json_name = parse_json_name(variable_name)
      json_value = dump(obj.instance_variable_get(variable_name))
      "#{json_name}: #{json_value}"
    end
    "{" + variables_with_value.join(", ") + "}"
  end

  def dump_array(array)
    json_dumps = array.map {|thing| dump(thing) }
    "[" + json_dumps.join(", ") + "]"
  end
  
  def dump_float(float)
    float.to_s
  end

  def dump_fixnum(digit)
    digit.to_s
  end
 
  def match(tag, matches)
    matches[tag] == nil ? tag : matches[tag]
  end
  
  def parse_json_name(variable)
    '"' + String(variable).sub(/@|:/,'') + '"'
  end
end
