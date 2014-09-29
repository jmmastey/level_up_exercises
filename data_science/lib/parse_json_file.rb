class ParseJsonFile
  require 'json'

  attr_accessor :data

  def initialize
    @data = []
  end

  def group_data_by_cohort
    @data.group_by { |dta| dta[:cohort] }
  end

  def load_json_file(filename)
    file = File.read(filename)
    parse_json(file)
  end

  def parse_json(json_data)
    @data = JSON.parse(json_data, { symbolize_names: true })
  end
end
