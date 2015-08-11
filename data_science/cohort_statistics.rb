require 'bigdecimal'

class CohortStatistics
	attr_accessor :values
  INTERVAL = 1.96
  def initialize(cohort_group, cohort_data)
  	@cohort_data = cohort_data
    @cohort_group = cohort_group
    @cohort_size = nil
    @cohort_converted = nil
    @values = {}
    cohort_stats
  end 

  def cohort_size
    @cohort_size = @cohort_data[@cohort_group].length.to_f
  end 

  def cohort_conversion_freq
    @converted = @cohort_data[@cohort_group].count(1).to_f
    @not_converted = @cohort_size - @converted
    @conversion_freq = @converted/cohort_size
  end  
  #p % ± 2 * SE
  def cohort_confidence_interval
    standard_error = standard_error(@conversion_freq, @cohort_size)
    bottom_range = @conversion_freq - INTERVAL * standard_error
    top_range = @conversion_freq + INTERVAL * standard_error
    [bottom_range, top_range]
  end

  def cohort_chi_square
    @values[@cohort_group] = {converted: @converted, not_converted: @not_converted}
  end

  def cohort_stats
    cohort_size
    cohort_conversion_freq
    cohort_confidence_interval
    cohort_chi_square    
  end

  private
  # Standard Error (SE) = Square root of (p * (1-p) / n)
  def standard_error(p, num_trials)
    numerator = p * (1-p)
    Math.sqrt(numerator/num_trials)
  end
end
