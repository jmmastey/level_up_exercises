class SplitTestCalculator
  attr_reader :control_group, :variation_group

  def initialize(stats = {})
    assign_fields(stats)
    run_calculations
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

  def run_calculations
  end
end
