require './file_reader'
require './cohort'

class DataScience
  attr_accessor :raw_data, :cohorts

  def initialize(file_path)
    @raw_data = FileReader.new(file_path).data
    load_cohorts
  end

  def cohorts_different?
    values = {}
    @cohorts.each do |name, cohort|
      symbol_name = (name.downcase + "group").to_sym
      values[name] = {}
      values[name][:conversions] = cohort.conversions
      values[name][:records] = cohort.records.size
    end
    ABAnalyzer::ABTest.new(values).different?
  end

  def to_s
    string = ""
    @cohorts.each do |name, cohort|
      string << cohort.to_s
      string << "\n"
    end
    string << "The cohorts are statistically different: #{cohorts_different?}"
  end

  private

  def load_cohorts
    @cohorts = {}
    @raw_data.each do |line|
      line = symbolize_keys(line)
      unless @cohorts[line[:cohort]]
        @cohorts[line[:cohort]] = Cohort.new(line[:cohort])
      end

      @cohorts[line[:cohort]].insert_record(line)
    end
  end

  def symbolize_keys(hash)
    result = {}
    hash.each do |key, value|
      result[key.to_sym] = value
    end
    result
  end
end

