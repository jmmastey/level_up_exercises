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
    all_conversions if cohort_name.nil?
    cohorts.count do |cohort|
      cohort.name.eql?(cohort_name) && cohort.conversion?
    end
  end

  def all_conversions
    cohorts.count { |cohort| cohort.conversion? }
  end
end
