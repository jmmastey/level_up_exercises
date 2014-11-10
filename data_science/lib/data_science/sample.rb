require_relative 'data_point'

class Sample
  attr_reader :data_points

  def initialize
    @data_points = []
  end

  def add_data_to_sample(data_source)
    data_source.each do |data|
      data_point = DataPoint.new(data)
      @data_points << data_point
    end
  end

  def sample_size
    @data_points.size
  end

  def conversions(group)
    @data_points.select { |visitor| visitor.cohort == group && visitor.result == 1 }.size
  end
end
