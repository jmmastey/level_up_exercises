require "statistics2"

class ChiSquare
  attr_reader :degrees_of_freedom, :confidence_level
  def initialize(params)
    @dataset = params[:dataset]
    @degrees_of_freedom = 1
    @confidence_level = 0.95
  end

  def value
    @dataset.groups.each_key.inject(0) do |sum, group_id|
      sum + chi_group_value(group_id)
    end
  end

  def significant?
    Statistics2.chi2X_(@degrees_of_freedom, value) > @confidence_level
  end

  private

  def chi_group_value(group_id)
    chi_success_value(group_id) + chi_fail_value(group_id)
  end

  def chi_success_value(group_id)
    chi_difference(
      observed_size: @dataset.success_count(group: group_id),
      group_size: @dataset.groups[group_id].size,
      global_percent: @dataset.success_percent
    )
  end

  def chi_fail_value(group_id)
    chi_difference(
      observed_size: @dataset.fail_count(group: group_id),
      group_size: @dataset.groups[group_id].size,
      global_percent: @dataset.fail_percent
    )
  end

  def chi_difference(params)
    observed_size = params[:observed_size]
    global_percent = params[:global_percent]
    group_size = params[:group_size]
    square_diff = (observed_size - global_percent * group_size)**2
    square_diff / (group_size * global_percent)
  end
end
