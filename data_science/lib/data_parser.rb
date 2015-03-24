require 'json'
class DataParser
  MIN_DATA_SIZE = 20
  attr_accessor :cohort_a, :cohort_b
  def initialize(file)
    @cohort_a = []
    @cohort_b = []
    data = File.read(file)
    data_set = JSON.parse(data)
    build_cohorts(data_set)
    validate_cohort_data_size
  end

  def build_cohorts(data_set)
    @cohort_a = data_set.select {|data| data["cohort"] == "A"}
    @cohort_b = data_set.select {|data| data["cohort"] == "B"}
  end

  def validate_cohort_data_size
    raise 'Insufficient data' unless @cohort_a.length >= MIN_DATA_SIZE ||
                                        @cohort_b.length >= MIN_DATA_SIZE 
  end
end
