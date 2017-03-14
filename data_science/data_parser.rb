require_relative './cohort.rb'
require 'json'

class DataParser
  attr_reader :unique_cohorts
  attr_reader :unique_cohorts_conversions

  def initialize(input_file)
    input_data = read_data(input_file)
    find_cohorts_and_conversions(input_data)
  end

  private

  def read_data(input_file)
    JSON.parse(File.read(input_file))
  end

  def find_cohorts_and_conversions(input_data)
    unique_cohorts = Hash.new(0)
    unique_cohorts_conversions = Hash.new(0)
    input_data.each do |data_point|
      cohort_name = data_point["cohort"].to_sym
      unique_cohorts[cohort_name] += 1
      unique_cohorts_conversions[cohort_name] += data_point["result"].to_i
    end
    @unique_cohorts = unique_cohorts
    @unique_cohorts_conversions =  unique_cohorts_conversions
  end
end
