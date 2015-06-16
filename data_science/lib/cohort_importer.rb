require 'json'
require 'cohort'

class InvalidFile < IOError; end

class CohortImporter
  attr_reader :cohorts, :groups

  GROUP = 'cohort'
  RESULT = 'result'

  def initialize(filename)
    raise InvalidFile, "JSON file must be passed to initialize" unless filename
    file = File.read(filename)
    @data = JSON.parse(file)
    @groups = transform_conversions(setup_groups)
    @cohorts = make_cohorts(@groups)
  end

  def setup_groups(groups={})
    @data.each do |record|
      groups[record[GROUP]] = { :conversions => 0, :non_conversions => 0 }
    end
    groups
  end

  def transform_conversions(groups)
    @data.each do |record|
      groups[record[GROUP]][:conversions] += 1 if record[RESULT] == 1
      groups[record[GROUP]][:non_conversions] += 1 if record[RESULT] == 0
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
