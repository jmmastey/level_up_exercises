require 'abanalyzer'
require_relative 'jsonparser.rb'

class Cohort
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def sample_size
    data.size
  end

  def conversions
    data.count { |hash| hash['result'] == 1 }
  end

  def conversion_rate
    conversions / sample_size.to_f
  end

  def standard_error
    (conversion_rate * (1 - conversion_rate)) / sample_size
  end

  def conversion_rate_range
    [conversion_rate - (2 * standard_error), conversion_rate + (2 * standard_error)]
  end

  def bounced
    data.count { |hash| hash['result'] == 0 }
  end
end
