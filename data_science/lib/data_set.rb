require_relative 'data_point'

class DataSet
  def initialize(data: [])
    @data = data
  end

  def count(criteria)
    return @data.length if criteria == :all
    @data.count { |data_point| data_point.match?(criteria) }
  end

  def possible_values(measure)
    values = @data.map { |data_point| data_point.value(measure) }
    values.uniq
  end
end
