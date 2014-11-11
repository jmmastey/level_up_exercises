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

  def conversions(cohort)
    @data_points.select { |visitor| visitor.cohort == cohort && visitor.result == 1 }.size
  end

  def cohort_size(cohort)
    @data_points.select { |visitor| visitor.cohort == cohort }.size
  end

  def conversion_rate(cohort)
    1.0 * conversions(cohort) / cohort_size(cohort)
  end

  def standard_error(cohort)
    Math.sqrt(conversion_rate("A") * (1 - conversion_rate("A")) / cohort_size("A"))
  end

  def error_bars(cohort)
    standard_error("A") * 1.96
  end

end
