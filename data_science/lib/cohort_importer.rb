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

  def setup_groups(groups = {})
    @data.each do |record|
      groups[record[@group]] = { conversions: 0, non_conversions: 0 }
    end
    groups
  end

  def transform_conversions(groups)
    @data.each do |record|
      groups[record[@group]][:conversions] += 1 if record[@result] == 1
      groups[record[@group]][:non_conversions] += 1 if record[@result] == 0
    end
    groups
  end

  def make_cohorts(groups)
    cohorts = []
    groups.each do |key, value|
      cohorts << Cohort.new(Hash[[[key, value]]])
    end
    cohorts
  end
end
