require 'json'
require_relative '../lib/cohort'
require_relative '../lib/visit'

class CohortLoader
  attr_accessor :filename, :cohorts

  def initialize(filename)
    @filename = filename
    @cohorts = { 'A' => Cohort.new('A'), 'B' => Cohort.new('B') }
  end

  def load
    JSON.parse(File.read(filename)).each do |visit_details|
      add_visit_details_to_cohort(visit_details)
    end
  end

  def sample_size(cohort_name = nil)
    return total_sample_size unless cohort_name
    cohorts[cohort_name].sample_size
  end

  def total_sample_size
    cohorts['A'].sample_size + cohorts['B'].sample_size
  end

  def conversions(cohort_name = nil)
    return all_conversions unless cohort_name
    cohorts[cohort_name].conversions
  end

  def conversion_rate(cohort_name = nil)
    return total_conversion_rate unless cohort_name
    cohorts[cohort_name].conversion_rate
  end

  def total_conversion_rate
    conversions.to_f / sample_size.to_f
  end

  def standard_error(cohort_name = nil)
    return total_standard_error unless cohort_name
    cohorts[cohort_name].standard_error
  end

  def total_standard_error
    rate = conversion_rate
    size = sample_size

    Math.sqrt((rate * (1 - rate)) / size)
  end

  def conversion_rate_range(cohort_name)
    cohorts[cohort_name].conversion_rate_range
  end

  def to_ab_format
    {
      'A' => cohorts['A'].generate_pass_fail_info,
      'B' => cohorts['B'].generate_pass_fail_info,
    }
  end

  def all_conversions
    cohorts['A'].conversions + cohorts['B'].conversions
  end

  private

  def add_visit_details_to_cohort(visit_details)
    visit = Visit.new(visit_details['result'], visit_details['date'])
    @cohorts[visit_details['cohort']].add_visit(visit)
  end
end
