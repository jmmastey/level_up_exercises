require 'json'

class CohortData
  attr_accessor :cohort_visits, :file_name

  def initialize(file_name)
    @file_name = file_name
  end

  def load_json_data_into_array
    puts "File #{file_name} not found" unless File.exist?(file_name)
    file = File.read(file_name)
    @cohort_visits = JSON.parse(file)
  rescue
    puts "File parsing error!!"
  end
end
