require "json"
class JsonParser
  def self.parse(file_name)
    raise ArgumentError unless File.exists?(file_name)
    data_json = JSON.parse(file_name.read)
    parsed_json = {}
    data_json.each do |data|
      parsed_json[data["date"]] ||= {}
      parsed_json[data["date"]][data["cohort"]] ||= 0
      parsed_json[data["date"]][data["cohort"]] += data["result"]
    end
    parsed_json
  end
end