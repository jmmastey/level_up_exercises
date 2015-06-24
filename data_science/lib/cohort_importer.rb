require 'json'
require 'cohort'

class InvalidFile < IOError; end

class CohortImporter
  attr_reader :cohorts, :groups

  def initialize(filename, group: 'cohort', result: 'result')
    raise InvalidFile, "JSON file must be passed to initialize" unless filename
    @group = group
    @result = result
    file = File.read(filename)
    @data = JSON.parse(file)
    @groups = transform_conversions(setup_groups)
    @cohorts = make_cohorts(@groups)
  end

  private

  def setup_groups
    groups = {}
    @data.each_with_object(groups) do |record|
      groups[record[@group]] = { conversions: 0, non_conversions: 0 }
    end
  end

  def transform_conversions(groups)
    @data.each_with_object(groups) do |record|
      type = record[@result] == 1 ? :conversions : :non_conversions
      groups[record[@group]][type] += 1
    end
  end

  def make_cohorts(groups)
    groups.reduce(Array.new) do |cohort, (key, value)|
      cohort << Cohort.new(Hash[[[key, value]]])
    end
  end
end
