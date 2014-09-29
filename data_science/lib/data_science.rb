class DataScience
  require_relative 'parse_json_file'
  require_relative 'split_test_calculator'

  attr_accessor :all_data, :calculator, :calculated_data

  def initialize(filename)
    parser = ParseJsonFile.new
    parser.load_json_file(filename)
    @all_data = parser.group_data_by_cohort
    @calculator = SplitTestCalculator.new
    @calculated_data = {}
  end

  def perform_all_calculations
    values = {}
    @all_data.each_key do |k|
      values[k] = { :conversions=>all_conversions(k),
                    :total=>cohort_sample_size(k) }
      @calculated_data[k] = { :conversionpct => conversion_percentage(k) }
      @calculated_data[k].store( :conversions, all_conversions(k))
      @calculated_data[k].store( :sample_size, cohort_sample_size(k))
      @calculated_data[k].store( :error_bars,
                                 @calculator.error_bars(all_conversions(k),
                                  cohort_sample_size(k)))
    end
    @calculator.calculate(values)
    @calculated_data[:chi_square] = @calculator.chi_square_score
    @calculated_data[:pvalue] = @calculator.chi_square_pvalue
    @calculated_data[:different] = @calculator.test_groups_are_different?
    @calculated_data
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
    @calculator.error_bars(conversions,total, confidence_int)
  end
end

#ds = DataScience.new("../source_data.json")
#puts ds.perform_all_calculations