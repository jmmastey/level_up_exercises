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
      cohort = res["cohort"].to_sym
      parsed_data[cohort] ||= {conversion: 0, nonconversion: 0}
      parsed_data[cohort][:conversion] += 1 if res["result"] > 0
      parsed_data[cohort][:nonconversion] += 1 if res["result"] == 0
    end

    parsed_data[:sample_size] = raw_data.length

    parsed_data
  end
end
