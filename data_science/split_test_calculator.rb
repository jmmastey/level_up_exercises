require_relative "chi_square"

class SplitTestCalculator
  attr_reader :groups

  def initialize(*groups)
    validate_stats(groups)
    @groups = groups
  end

  def better_group
    @groups.max_by(&:conversion_rate)
  end

  def confidence_level
    calc = ChiSquare.new
    calc.confidence_level(*@groups)
  end

  private

  def validate_stats(groups)
    raise_group_count_error if groups.count < 2
  end

  def group_unassigned_error
    raise ArgumentError, "Must have at least 2 groups."
  end
end
