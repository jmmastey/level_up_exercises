require_relative "split_test_calculator"
require_relative "split_test_group"

class OutputFormatter
  def initialize
    init_format_map
  end

  def format(data)
    return data.to_s unless @format_map.include?(data.class)

    send(@format_map[data.class], data)
  end

  private

  def format_better_group(group)
    "Group '#{group.name}' is superior."
  end

  def format_calculator(calculator)
    groups = calculator.groups

    better_group = format_better_group(calculator.better_group)
    confidence = format_confidence_level(calculator.confidence_level)
    formatted_groups = groups.map { |group| format_group(group) }

    formatted_groups.join("\n") <<
      "\n#{better_group}\n" \
      "#{confidence}\n"
  end

  def format_confidence_level(confidence_level)
    "Confidence in variation: #{format_pct(confidence_level)}"
  end

  def format_group(group)
    name = group.name
    conversions = group.conversions
    views = group.views
    rate = format_pct(group.conversion_rate)
    error = format_pct(group.conversion_rate_error)

    "Group #{name}\n" \
    "  #{conversions} conversions from #{views} views\n" \
    "  #{rate} \xc2\xb1 #{error} conversion rate\n"
  end

  def format_pct(percent)
    "#{sprintf("%.2f", percent * 100)}%"
  end

  def init_format_map
    @format_map = {
      SplitTestCalculator => :format_calculator,
      SplitTestGroup => :format_group
    }
  end
end
