require_relative 'json_parser'

class Experiment
  attr_accessor :group_stats, :data

  STANDARD_DEVIATION = 2 # For 95% confidence rate

  def initialize(file_name)
    @data = JsonParser.parse(File.open(file_name, "r"))
    @group_stats ||= {}
    @data.keys.each do |cohort|
      @group_stats[cohort] ||= {}
    end
  end

  def observed_conversion_rate(cohort)
    return @group_stats[cohort]["conversion_rate"] if
                              @group_stats[cohort].key? "conversion_rate"
    cohort_stats = @data[cohort]
    conversion_rate = ((cohort_stats["conversions"].to_f / cohort_stats["total_visits"])).round(4)
    @group_stats[cohort]["conversion_rate"] = conversion_rate
  end

  def standard_error(cohort)
    return @group_stats[cohort]["standard_error"] if
                             @group_stats[cohort].key? "standard_error"
    conversion_rate = @group_stats[cohort]["conversion_rate"] || observed_conversion_rate(cohort)
    trials          = @data[cohort]["total_visits"]
    error           = Math.sqrt((conversion_rate * (1 - conversion_rate)) / trials).round(4)
    @group_stats[cohort]["standard_error"] = error
  end

  def expected_conversion_rate(cohort)
    return @group_stats[cohort]["expected_conversion_rate"] if
                              @group_stats[cohort].key? "expected_conversion_rate"
    conversion_rate = @group_stats[cohort]["conversion_rate"] || observed_conversion_rate(cohort)
    error           = @group_stats[cohort]["standard_error"]  || standard_error(cohort)
    @group_stats[cohort]["expected_conversion_rate"] =
             { max: (conversion_rate * 100 + (STANDARD_DEVIATION * error)).round(2),
               min: (conversion_rate * 100 - (STANDARD_DEVIATION * error)).round(2),
             }
  end
end

