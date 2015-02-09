require 'abanalyzer'
class Cohort
  attr_accessor :name, :conversion_count, :sample_size, :conversion_rate

  def initialize(name, data)
    raise "Corrupted Data!?" unless name && data
    @name = name.to_sym
    cohort_data = data.select { |data| data.cohort == name }
    @sample_size = cohort_data.count
    @conversion_count = count_conversions(cohort_data)
    @conversion_rate = conversion_rates
  end

  private

  def count_conversions(data)
    data.select { |data| data.result == 1 }.count
  end

  def conversion_rates
    rates = ABAnalyzer.confidence_interval(conversion_count, sample_size, 0.95)
    rates.map { |x| (x * 100).round(2).to_s + '%' }
  end
end
