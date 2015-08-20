require './file_reader'
require './cohort'

class DataScience
  attr_accessor :raw_data, :cohorts

  def initialize(file_path)
    @cohorts = load_cohorts(FileReader.new(file_path).data)
  end

  def different_cohorts?
    ABAnalyzer::ABTest.new(ab_test_values).different?
  end

  def to_s
    result = @cohorts.each_with_object("") do |(_name, cohort), string|
      string << cohort.to_s
      string << "\n"
    end
    result << "The cohorts are statistically different: #{different_cohorts?}"
  end

  private

  def ab_test_values
    @cohorts.each_with_object({}) do |(name, cohort), values|
      values[name] = cohort_test_hash(cohort)
    end
  end

  def cohort_test_hash(cohort)
    {
      conversions: cohort.conversions,
      records: cohort.records
    }
  end

  def load_cohorts(raw_cohorts)
    raw_cohorts.each_with_object({}) do |line, cohorts|
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
