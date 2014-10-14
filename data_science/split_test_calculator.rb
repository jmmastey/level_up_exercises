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

  def to_s
    better_group = format_better_group
    confidence = format_confidence_level

    groups.join("\n") << "\n#{better_group}\n#{confidence}\n"
  end

  private

  def format_better_group
    "Group '#{better_group.name}' is superior."
  end

  def format_confidence_level
    "Confidence in superiority: #{format_pct(confidence_level)}"
  end

  def format_pct(percent)
    "#{sprintf("%.2f", percent * 100)}%"
  end

  def validate_stats(groups)
    raise_group_count_error(groups.count) if groups.count < 2
  end

  def raise_group_count_error(actual_count)
    message = "Must have at least 2 groups (received #{actual_count})."
    raise ArgumentError, message
  end
end
