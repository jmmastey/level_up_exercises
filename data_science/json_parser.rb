require 'json'

class JsonParser
  def initialize
    @test_data = {}
  end

  def parse_data(json_file)
    raise("File not found") unless File.exist?(json_file)
    json_obj = File.read(json_file)
    JSON.parse(json_obj).each do |row|
      populate_data row
    end
    @test_data
  end

  def populate_data(row)
    cohort = row['cohort']
    @test_data[cohort] ||= { total_samples: 0.00, conversions: 0.00 }
    @test_data[cohort][:total_samples] += 1
    @test_data[cohort][:conversions] += row['result']
  end
end
