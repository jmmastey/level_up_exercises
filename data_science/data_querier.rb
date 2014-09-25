require 'forwardable'
require_relative "data_entry"

class DataQuerier
  attr_reader :groups

  def initialize(data = [])
    validate_data(data)
    @test_data = data
    @groups = group_data(data)
  end

  def count_conversions(cohort = nil)
    entries = @test_data
    entries = groups[cohort] if cohort

    entries.count { |entry| entry.conversion? }
  end

  def count_views(cohort = nil)
    entries = @test_data
    entries = groups[cohort] if cohort

    entries.count
  end

  private

  def group_data(data)
    data.group_by(&:cohort)
  end

  def validate_data(data)
    valid = data.is_a?(Array) && data.all? { |entry| entry.is_a?(DataEntry) }
    validate_data_error unless valid
  end

  def validate_data_error
    raise ArgumentException, "Data must be an array of DataEntries."
  end
end
