require 'json'
require_relative 'cohort'

class CohortConverter
  def initialize(json_file)
    @data = JSON.parse(file_contents(json_file))
  end

  def cohorts
    map = cohorts_map
    @data.each do |row|
      map[row['cohort']].add_attempt
      map[row['cohort']].add_success if row['result'].to_i == 1
    end
    map.values
  end

  private

  def cohorts_map
    cohort_collection = cohort_names.inject([]) { |cohorts, name| cohorts << Cohort.new( name: name ) }
    cohort_collection.each_with_object({}) { |cohort, map| map[cohort.name] = cohort }
  end

  def cohort_names
    @data.inject([]) { |names, row| names << row['cohort'] }.uniq
  end

  def file_contents(file_path)
    File.open(file_path, 'r') { |f| f.read }
  end
end
