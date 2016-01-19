require "JSON"

class DataLoader
  def self.load_data(json_file)
    File.open(json_file, "r") do |f|
      parse_data(JSON.parse(f.read))
    end
  end

  def self.parse_data(raw_data)
    parsed_data = { sample_size: raw_data.length }

    raw_data.each do |res|
      result = res["result"] == 1 ? :conversion : :nonconversion

      parsed_data[res["cohort"].to_sym] ||= { conversion: 0, nonconversion: 0 }
      parsed_data[res["cohort"].to_sym][result] += 1
    end

    parsed_data
  end
end
