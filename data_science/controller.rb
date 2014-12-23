require_relative 'cohort'
require_relative 'data_point'
require_relative 'experiment'
require 'json'

# experiment.data_points.cohort.positive_conversions
# experiment.data_points.cohort.length
# experiment.total_views
# experiment.data_points.
# cohort.data_points

#experiment.cohorts.data_point = 500
#experiment.datapoint = 1000


class Controller

  def initialize(filename)
    run(filename)
    @data_points = []
  end

  def run(filename)
    @data_points = create_data_points(parse(filename))
    experiment = Experiment.new(@data_points)
  end

  private

  def parse(filepath)
    JSON.parse(File.read(filepath))
  end

  def create_data_points(rows)
    rows.map { |row| DataPoint.new(row["cohort"], row["result"]) }
  end
end

Controller.new('test.json')