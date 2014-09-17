require "json_reader"
require "cohort"

class DataScience
  include JsonReader
  attr_accessor :cohorts

  def initialize(input_file = "source_data.json")
    process_file(input_file)
  end

  private

  def process_file(input_file)
    data = read(input_file)
    extract_cohorts(data)
  end

  def extract_cohorts(data)
    @cohorts = {}
    data.each do |item|
      @cohorts[item["cohort"]] ||= Cohort.new
      @cohorts[item["cohort"]].samples.push(item)
    end
  end


end
