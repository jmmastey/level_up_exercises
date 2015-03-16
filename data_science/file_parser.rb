require 'json'
require_relative 'cohort'

class FileParser
  attr_reader :cohort_a, :cohort_b

  MIN_DATA_SIZE = 20

  def initialize(filename)
    @cohort_a = []
    @cohort_b = []

    load(filename)
  end

  private

  def load(filename)
    data = File.read(filename)
    import_data(data)
  end

  private

  def import_data(data)
    hash_array = JSON.parse(data)
    split_cohorts(hash_array)
    validate_cohorts
  end

  def split_cohorts(hash_array)
    @cohort_a = hash_array.select { |hash| hash["cohort"].downcase == "a" }
    @cohort_b = hash_array.select { |hash| hash["cohort"].downcase == "b" }
  end

  def valid_cohort_id?(cohort_id)
    cohort_id == 'a' || cohort_id == 'b'
  end

  def validate_cohorts
    raise "Cohort A is too small!" unless @cohort_a.length >= MIN_DATA_SIZE
    raise "Cohort B is too small!" unless @cohort_b.length >= MIN_DATA_SIZE
  end
end
