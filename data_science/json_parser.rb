require "json"

class JsonParser
  def self.parse(file_name)
    raise ArgumentError unless File.exist?(file_name)
    data_json = JSON.parse(file_name.read)
    parsed_json = format_results(data_json) unless data_json.nil?
    file_name.close
    parsed_json
  end

  def self.format_results(data_json)
    parsed_json = {}
    data_json.each do |data|
      parsed_json[data["cohort"]] ||= {}
      parsed_json[data["cohort"]]["total_visits"] ||= 0
      parsed_json[data["cohort"]]["conversions"]  ||= 0
      parsed_json[data["cohort"]]["total_visits"] += 1
      parsed_json[data["cohort"]]["conversions"]  += data["result"].to_i
    end
    parsed_json
  end
end

