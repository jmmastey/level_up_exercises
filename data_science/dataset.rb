require_relative 'datum'

class Dataset
  attr_accessor :results

  def initialize(data)
    @results = []
    data.each { |line| @results << Datum.new(line) }
  end

  def total_sample_size
    @results.length
  end

  def number_of_conversions(cohort)
    1
  end
end
