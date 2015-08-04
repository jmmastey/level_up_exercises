require 'json'

class BadDataFile < StandardError
end

class DataSet
  attr_reader :file_name, :data

  def initialize(data_points: [], file_name: nil)
    @file_name = file_name
    @data = {}
    data_points += read_json if file_name
    process_raw_data(data_points) unless data_points.empty?
  end

  def read_json
    data_s = File.read(file_name)
    return [] if data_s.empty?
    JSON.parse(data_s, symbolize_names: true)
  rescue JSON::ParserError
    raise BadDataFile, "Unable to parse #{file_name}"
  end

  def process_raw_data(data_points)
    data_points.each do |data_point|
      name = data_point[:cohort]
      data[name] = { views: 0, conversions: 0 } unless data.key?(name)
      data[name][:views] += 1
      data[name][:conversions] += 1 if data_point[:result] == 1
    end
  end

  def cohorts
    data.keys
  end

  def views(cohort)
    return 0 unless data[cohort]
    data[cohort][:views]
  end

  def conversions(cohort)
    return 0 unless data[cohort]
    data[cohort][:conversions]
  end
end
