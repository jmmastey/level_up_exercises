require 'abanalyzer'

class DataManager
  @sample_size = 0
  attr_accessor :reader
  def load(reader)
    @reader = reader
  end

  def sample_size(cohort_name = nil)
    raise ArgumentError, "reader not initialized" unless @reader
    return @reader.data_hash.count unless cohort_name
    @reader.data_hash.count { |item| item['cohort'] == cohort_name }
  end

  def conversion_size(cohort_name = nil)
    raise ArgumentError, "reader not initialized" unless @reader
    return cohort_conversion_size(cohort_name) if cohort_name
    @reader.data_hash.count { |item| item['result'] == 1 }
  end

  def conversion_rate(cohort = nil)
    raise ArgumentError, "reader not initialized" unless @reader
    converted = conversion_size(cohort)
    total = sample_size(cohort)
    ((converted.to_f / total.to_f) * 100).round(2)
  end

  def calc_chi_square
    values = {}
    prepare_data_by_group(values, :agroup, "A")
    prepare_data_by_group(values, :bgroup, "B")
    tester = ABAnalyzer::ABTest.new(values)
    tester.chisquare_p.round(3)
  end

  def prepare_data_by_group(values, group_name, group_code)
    converted_group_size = conversion_size(group_code)
    total = sample_size(group_code) - converted_group_size
    values[group_name] = { convert: converted_group_size, no_convert: total }
  end

  private

  def cohort_conversion_size(name)
    @reader.data_hash.count do |item|
      item['cohort'] == name && item['result'] == 1
    end
  end
end
