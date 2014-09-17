class Cohort
  attr_accessor :samples

  def initialize
    @samples = []
  end

  def sample_size
    samples.length
  end

  def conversion_count
    samples.count { |x| x["result"] == 1 }
  end

  def conversion_rate
    conversion_count.to_f / sample_size.to_f
  end
end
