require "JSON"

class DataLoader
  def self.load_data(json_file)
    data = {}

    File.open(json_file, "r") do |f|
      parse_data(JSON.parse(f.read))
    end
  end

  def self.parse_data(raw_data)
    parsed_data = {}
    raw_data.each do |res|
      parsed_data[res["cohort"]] ||= 0
      parsed_data[res["cohort"]] += res["result"]
    end

    parsed_data
  end
end
