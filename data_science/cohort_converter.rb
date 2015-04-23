require 'json'
require_relative 'cohort'

class CohortConverter
  def initialize(json_file)
    @data = JSON.parse(file_contents(json_file))
  end

  def cohorts
    new_cohorts = @data.each_with_object(cohorts_map) do |row, cohorts|
      cohorts[row['cohort']].add_attempt
      cohorts[row['cohort']].add_success if row['result'].to_i == 1
    end
    new_cohorts.values
  end

  private

  def cohorts_map
    cohort_names.each_with_object({}) { |name, cohorts| cohorts[name] = Cohort.new(name: name) }
  end

  def cohort_names
    @data.map { |row| row['cohort'] }.uniq
  end

  def file_contents(file_path)
    File.open(file_path, 'r') { |f| f.read }
  end
end
