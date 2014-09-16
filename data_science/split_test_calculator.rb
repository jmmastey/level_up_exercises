require_relative "chi_square"

class SplitTestCalculator
  attr_reader :control_group, :variation_group

  def initialize(control_group, variation_group)
    validate_stats(control_group, variation_group)

    @control_group = control_group
    @variation_group = variation_group
  end

  def better_group
    if @control_group.conversion_rate == @variation_group.conversion_rate
      nil
    elsif @control_group.conversion_rate < @variation_group.conversion_rate
      :variation_group
    else
      :control_group
    end
  end

  def confident?
    control_min, control_max = @control_group.conversion_rate_range
    variation_min, variation_max = @variation_group.conversion_rate_range

    (control_min < variation_max) || (variation_min < control_max)
  end

  def confidence_level
    calc = ChiSquare.new
    calc.confidence_level(@control_group, @variation_group)
  end

  private

  def validate_stats(control_group, variation_group)
    group_unassigned_error(:control_group) unless control_group
    group_unassigned_error(:variation_group) unless variation_group
  end

  def group_unassigned_error(group)
    raise ArgumentError, "#{group} must be assigned."
  end
end
