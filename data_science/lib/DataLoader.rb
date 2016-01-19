require "JSON"

class DataLoader
  attr_accessor :parsed_data

  def self.load_data(json_file)
    @parsed_data = {
      A: { conversion: 0, total: 0 },
      B: { conversion: 0, total: 0 },
    }

    File.open(json_file, "r") do |f|
      parse_data(JSON.parse(f.read))
    end
  end

  def self.parse_data(raw_data)
    raw_data.each do |res|
      cohort = res["cohort"].to_sym
      @parsed_data[cohort][:conversion] += res['result']
      @parsed_data[cohort][:total] += 1
    end

    @parsed_data
  end
end
