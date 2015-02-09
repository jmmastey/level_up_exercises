require 'abanalyzer'
class Cohort
  attr_accessor :name, :conversion_count, :sample_size, :conversion_rate

  def initialize(name, data_list)
    raise "Corrupted Data!?" unless name && data_list
    @name = name.to_sym
    cohort_data = data_list.select { |data| data.cohort == name }
    @sample_size = cohort_data.count
    @conversion_count = set_conversion_count(cohort_data)
    @conversion_rate = conversion_rates
  end

  private
  def set_conversion_count(data_list)
    data_list.select { |data| data.result == 1 }.count
  end

  def conversion_rates
    rates = ABAnalyzer.confidence_interval(self.conversion_count, self.sample_size, 0.95)
    rates.map { |x| (x * 100).round(2).to_s + '%' }
  end
end
