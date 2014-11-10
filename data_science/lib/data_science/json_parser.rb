class JsonParser
  def self.parse_file(json_file)
    json_string = IO.read(json_file)
    JSON.parse(json_string)
  end
end
