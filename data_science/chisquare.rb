require "statistics2"

class ChiSquare
  attr_reader :degrees_of_freedom, :confidence_level
  def initialize(params)
    @dataset = params[:dataset]
    @degrees_of_freedom = 1
    @confidence_level = 0.95
  end

  def value
    @dataset.groups.each_value.inject(0) do |sum, group|
      sum + chi_group_value(group)
    end
  end

  def significant?
    pvalue = Statistics2.chi2X_(@degrees_of_freedom, value)
    pvalue > @confidence_level
  end

  def to_s
    significant = (significant?) ? "is significant" : "is not significant"
    "chi squared value is '%f' and the result #{significant}" % value
  end

  private

  def chi_group_value(group)
    chi_success_value(group) + chi_fail_value(group)
  end

  def chi_success_value(group)
    chi_difference(
      observed_size: group.success_count,
      group_size: group.count,
      global_percent: @dataset.success_percent
    )
  end

  def chi_fail_value(group)
    chi_difference(
      observed_size: group.fail_count,
      group_size: group.count,
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
