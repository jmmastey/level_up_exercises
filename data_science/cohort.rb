class Cohort
  attr_accessor :name, :conversion, :standard_error, :stats

  def initialize(name)
    @name = name
    @stats = {positive: 0, negative: 0, total: 0}
  end

  def eql?(other_obj)
    other_obj.name == @name
  end

  alias_method :==, :eql?

  def to_s
    "#{@name}: #{conversion||=0 * 100} +/- #{standard_error||=0 * 2}\n"  
  end

end
