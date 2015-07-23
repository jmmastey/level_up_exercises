require 'abanalyzer'
require_relative 'cohort'

class DataManager
  attr_accessor :reader

  def initialize(reader)
    raise ArgumentError, "reader not initialized" unless reader
    @sample_size = 0
    @cohorts = { A: init_cohort(reader, 'A'), B: init_cohort(reader, 'B') }
  end

  def init_cohort(reader, name)
    success_count = reader.data_hash.count do |item|
      item['cohort'] == name && item['result'] == 1
    end
    failure_count = reader.data_hash.count do |item|
      item['cohort'] == name && item['result'] == 0
    end
    Cohort.new(success_count, failure_count)
  end

  def sample_size(cohort_name = nil)
    sum = 0
    return 0 if @cohorts[cohort_name].nil? unless cohort_name.nil?
    sum = @cohorts[cohort_name].total_sample_size unless cohort_name.nil?
    @cohorts.values.each { |c| sum += c.total_sample_size } if cohort_name.nil?
    sum
  end

  def conversion_size(cohort_name = nil)
    conversions = 0
    return cohort_conversion_size(cohort_name) if cohort_name
    @cohorts.values.each { |c| conversions += c.success_count } if cohort_name.nil?
    conversions
  end

  def conversion_rate(cohort = nil)
    converted = conversion_size(cohort)
    total = sample_size(cohort)
    ((converted.to_f / total.to_f) * 100).round(2)
  end

  def calc_chi_square
    values = {}
    prepare_data_by_group(values, :agroup, :A)
    prepare_data_by_group(values, :bgroup, :B)
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
    @cohorts[name].success_count
  end
end
