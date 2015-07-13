require 'json'

require './cohort.rb'

class DataScience
  attr_accessor :cohorts, :sample_size

  def initialize(json_file)
    json_data = open(json_file, &:read)
    json = JSON.parse(json_data).to_a
    @sample_size = json.count

    raw_cohorts = json.partition { |item| item['cohort'].downcase == 'a' }
    @cohorts = raw_cohorts.map { |cohort_info| Cohort.new(cohort_info) }
  end

  def report_all
    @cohorts.each(&:report_all)
  end
end

DataScience.new('data_export_2014_06_20_15_59_02.json').report_all
