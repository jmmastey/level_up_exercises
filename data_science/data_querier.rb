require 'forwardable'
require_relative "data_entry"

class DataQuerier
  extend Forwardable
  include Enumerable

  attr_reader :test_data

  def_delegators :test_data, :each

  def initialize(data = [])
    validate_data(data)
    @test_data = data
  end

  def count_cohort_conversions(cohort)
    count { |entry| entry.cohort == cohort && entry.conversion? }
  end

  def count_cohort_views(cohort)
    count { |entry| entry.cohort == cohort }
  end

  private

  def validate_data(data)
    unless data.is_a?(Array) && data.all? { |entry| entry.is_a?(DataEntry) }
      raise ArgumentException, "Data must be an array of DataEntries."
    end
  end
end
