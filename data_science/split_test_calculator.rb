class SplitTestCalculator
  attr_reader :control_group, :variation_group

  def initialize(stats = {})
    assign_fields(stats)
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

  def assign_fields(stats)
    @control_group = SplitTestGroup.new(
      conversions: stats[:control_conversions],
      views: stats[:control_views]
    )
    @variation_group = SplitTestGroup.new(
      conversions: stats[:variation_conversions],
      views: stats[:variation_views]
    )
  end
end
