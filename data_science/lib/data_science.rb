class DataScience
  require_relative 'parse_json_file'
  require_relative 'split_test_calculator'

  attr_accessor :all_data

  def initialize(filename)
    parser = ParseJsonFile.new(filename)
    @all_data = parser.group_data_by_cohort
    @calculator = SplitTestCalculator.new
  end

  def cohort_sample_size(cohort)
    specific_cohort(cohort)[cohort].length.to_f
  end

  def specific_cohort(cohort_id)
    @all_data.select { |item| cohort_id == item }
  end

  def all_conversions(cohort_id)
    conv_data = specific_cohort(cohort_id)
    conv_data[cohort_id].select { |item| item[:result] == 1 }.length.to_f
  end

  def conversion_percentage(cohort_id)
    conversions = all_conversions(cohort_id)
    total = cohort_sample_size(cohort_id)
    (conversions / total)
  end

  def error_bars(cohort_id, confidence_int = 0.95)
    conversions = all_conversions(cohort_id)
    total = cohort_sample_size(cohort_id)
    @calculator.conversion_percentage(conversions,total, confidence_int)
  end
end

ds = DataScience.new("../source_data.json")
puts ds.error_bars("A")