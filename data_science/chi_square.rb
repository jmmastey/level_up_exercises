require 'statistics2'

class ChiSquare
  def confidence_level(*groups)
    degrees_of_freedom = groups.length - 1
    statistic = test_statistic(*groups)

    Statistics2.chi2X_(degrees_of_freedom, statistic)
  end

  def test_statistic(*groups)
    conversion_sum = sum_fields(groups, :conversions)
    view_sum = sum_fields(groups, :views)
    estimated_proportion = estimate_proportion(conversion_sum, view_sum)

    groups.inject(0) do |statistic, group|
      statistic + calculate_group_statistic(group, estimated_proportion)
    end
  end

  private

  def calculate_group_statistic(group, estimated_proportion)
    non_conversions = group.views - group.conversions
    expected_conversions = estimated_proportion * group.views
    expected_non_conversions = (1 - estimated_proportion) * group.views

    calculate_test_statistic_part(group.conversions, expected_conversions) +
      calculate_test_statistic_part(non_conversions, expected_non_conversions)
  end

  def calculate_test_statistic_part(observed, expected)
    ((observed - expected)**2) / expected
  end

  def estimate_proportion(conversions, views)
    conversions.to_f / views
  end

  def sum_fields(objects, field)
    objects.inject(0) { |sum, obj| sum + obj.send(field) }
  end
end
