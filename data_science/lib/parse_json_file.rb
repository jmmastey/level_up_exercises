class ParseJsonFile
  require 'json'

  attr_accessor :data

  def initialize(filename)
    @data = []
    parse_json_file(filename)
  end

  def group_data_by_cohort
    @data.group_by { |dta| dta[:cohort] }
  end

  private

  def parse_json_file(filename)
    file = File.read(filename)
    @data = JSON.parse(file, { symbolize_names: true })
  end
end
