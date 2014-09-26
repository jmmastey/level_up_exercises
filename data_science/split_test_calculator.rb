require_relative "chi_square"

class SplitTestCalculator
  attr_reader :groups

  def initialize(*groups)
    puts groups #TODO: REMOVE
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
    raise_group_count_error(groups.count) if groups.count < 2
  end

  def raise_group_count_error(actual_count)
    message = "Must have at least 2 groups (received #{actual_count})."
    raise ArgumentError, message
  end
end
