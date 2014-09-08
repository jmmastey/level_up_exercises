require "./matching"

class JSONParser
  def dump(thing)
    Match(thing, nil => "null",
                 false => "false",
                 true => "true",
                 Float => -> { dump_float(thing) },
                 Fixnum => -> { dump_fixnum(thing) },
                 String => -> { dump_string(thing) },
                 Array => -> { dump_array(thing) },
                 Object => -> { dump_object(thing) })
  end

  private

  def dump_string(str)
    encoded = str.chars.map do |c|
      Match(c, '"' => "\"",
               '\\' => '\\\\',
               "\n" => '\\n',
               "\r" => '\\r',
               "\b" => '\\b',
               "/" => "\/",
               "\f" => '\\f',
               "\t" => '\\t',
               Else => c)
    end
    '"' + encoded.join + '"'
  end

  def dump_object(obj)
    json_object_members = obj.instance_variables.map do |variable_name|
      json_name = parse_json_name(variable_name)
      json_value = dump(obj.instance_variable_get(variable_name))
      "#{json_name}: #{json_value}"
    end
    "{" + json_object_members.join(", ") + "}"
  end

  def dump_array(array)
    json_array_values = array.map { |thing| dump(thing) }
    "[" + json_array_values.join(", ") + "]"
  end

  def dump_float(float)
    float.to_s
  end

  def dump_fixnum(digit)
    digit.to_s
  end

  def parse_json_name(variable)
    '"' + String(variable).sub(/@|:/, "") + '"'
  end
end
