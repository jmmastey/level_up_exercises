require_relative 'json_parser'

class Experiment
  attr_accessor :group_stats

  STANDARD_DEVIATION = 2 # For 95% confidence rate

  def initialize(file_name)
    @data = JsonParser.parse(File.open(file_name,"r"))
    @group_stats ||= {}
  end

  def observed_conversion_rate(cohort)
    cohort_stats = @data[cohort]
    conversion_rate = (100 * (cohort_stats["conversions"].to_f / cohort_stats["total_visits"].to_f)).round(2)
    conversion_rate
  end

  def total_visits
    total = 0
    @data.values.each do |data|
      total += data["total_visits"]
    end
    total
  end

  def standard_error(cohort)
    conversion_rate = observed_conversion_rate(cohort)/100
    trials          = @data[cohort]["total_visits"]
    square_error    = (conversion_rate * (1 - conversion_rate))/trials
    error           = (Math.sqrt(square_error)*100).round(2)
  end

  def true_conversion_rate(cohort)
    { max: observed_conversion_rate(cohort) + (STANDARD_DEVIATION * standard_error(cohort)),
      min: observed_conversion_rate(cohort) - (STANDARD_DEVIATION * standard_error(cohort))
    }
  end
end
