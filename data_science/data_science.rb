require './file_reader'
require './cohort'

class DataScience
  attr_accessor :raw_data, :cohorts

  def initialize(file_path)
    @raw_data = FileReader.new(file_path).data
    load_cohorts
  end

  def cohorts_different?
    cohorts_hash = @cohorts.each_with_object({}) do |(name, cohort), values|
      values[name] = {}
      values[name][:conversions] = cohort.conversions
      values[name][:records] = cohort.records.size
    end
    ABAnalyzer::ABTest.new(cohorts_hash).different?
  end

  def to_s
    result = @cohorts.each_with_object("") do |(_name, cohort), string|
      string << cohort.to_s
      string << "\n"
    end
    result << "The cohorts are statistically different: #{cohorts_different?}"
  end

  private

  def load_cohorts
    @cohorts = @raw_data.each_with_object({}) do |line, cohorts|
      line = symbolize_keys(line)
      unless cohorts[line[:cohort]]
        cohorts[line[:cohort]] = Cohort.new(line[:cohort])
      end

      cohorts[line[:cohort]].insert_record(line)
    end
  end

  def symbolize_keys(hash)
    hash.each_with_object({}) do |(key, value), result|
      result[key.to_sym] = value
    end
  end
end
