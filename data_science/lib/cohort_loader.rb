require 'json'
require_relative '../lib/cohort'

class CohortLoader
  attr_accessor :filename, :cohorts

  def initialize(filename)
    @filename = filename
  end

  def load
    @cohorts = JSON.parse(File.read(filename)).map do |cohort|
      Cohort.new(cohort)
    end
  end

  def sample_size(cohort_name = nil)
    return cohorts.length if cohort_name.nil?
    cohorts.count { |cohort| cohort.name.eql?(cohort_name) }
  end

  def conversions(cohort_name = nil)
    return all_conversions if cohort_name.nil?
    cohorts.count do |cohort|
      cohort.name.eql?(cohort_name) && cohort.conversion?
    end
  end

  def conversion_rate(cohort_name = nil)
    conversions(cohort_name).to_f / sample_size(cohort_name).to_f
  end

  def standard_error(cohort_name = nil)
    p = conversion_rate(cohort_name)
    n = sample_size(cohort_name)

    Math.sqrt((p * (1 - p)) / n)
  end

  def conversion_rate_range(cohort_name)
    range = []
    range << conversion_rate(cohort_name) - standard_error(cohort_name)
    range << conversion_rate(cohort_name) + standard_error(cohort_name)
    range
  end

  def to_ab_format
    values = {}
    values['A'] = generate_pass_fail_info('A')
    values['B'] = generate_pass_fail_info('B')
    values
  end

  private

  def all_conversions
    cohorts.count(&:conversion?)
  end

  def generate_pass_fail_info(cohort_name)
    {
      pass: conversions(cohort_name),
      fail: sample_size(cohort_name) - conversions(cohort_name),
    }
  end
end
