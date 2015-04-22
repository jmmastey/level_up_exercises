CohortNameError = Class.new(RuntimeError)

class Cohort

  attr_accessor :name
  attr_accessor :sample_size
  attr_accessor :num_conversions
  attr_accessor :conversion_rate
  attr_accessor :std_dev

  def initialize(population_data)
    @name = get_cohort_name(population_data)
    @sample_size = population_data.length
    @num_conversions = get_num_conversions(population_data)
    @conversion_rate = compute_conversion_rate
    @std_dev = compute_std_dev
  end

  private
  def get_cohort_name(population_data)
    current_cohort = population_data[0]["cohort"] 
    population_data.each do |entry|
      raise CohortNameError if entry["cohort"] != current_cohort
    end
    @name = current_cohort.to_sym
  end

  private 
  def get_num_conversions(population_data)
    @num_conversions = 0.0
    population_data.each do |entry|
      @num_conversions += entry["result"].to_f
    end
    @num_conversions
  end

  public
  def compute_conversion_rate
    @conversion_rate = @num_conversions/@sample_size
  end

  def compute_std_dev
    @std_dev = Math.sqrt(@conversion_rate*(1-@conversion_rate)/@sample_size)
  end

  def compute_confidence_interval_95pct
    interval = @std_dev*1.96
    [@conversion_rate - interval, @conversion_rate + interval]
  end
    

end
