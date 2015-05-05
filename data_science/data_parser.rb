require_relative './cohort.rb'
require 'json'

class DataParser
  attr_reader :cohorts_sample_size
  attr_reader :cohorts_num_conversions

  def initialize(input_file)
    input_data = read_data(input_file)
    find_cohorts_and_conversions(input_data)
  end

  private

  def read_data(input_file)
    JSON.parse(File.read(input_file))
  end

  def find_cohorts_and_conversions(input_data)
    @cohorts_sample_size = Hash.new(0)
    @cohorts_num_conversions = Hash.new(0)
    input_data.each do |data_point|
      cohort_name = data_point["cohort"].to_sym
      @cohorts_sample_size[cohort_name] += 1
      @cohorts_num_conversions[cohort_name] += data_point["result"].to_i
    end
  end
end
