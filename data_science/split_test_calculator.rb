class SplitTestCalculator
  attr_reader :control_group, :variation_group

  def initialize(stats = {})
    validate_stats(stats)

    @control_group = stats[:control_group]
    @variation_group = stats[:variation_group]
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

  private

  def validate_stats(stats)
    raise ArgumentError, ":control_group must be assigned." unless stats[:control_group]
    raise ArgumentError, ":variation_group must be assigned." unless stats[:variation_group]
  end
end
