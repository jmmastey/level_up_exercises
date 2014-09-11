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
    text = {
      nil => "Neither group is superior.",
      control_group: "The control group is superior.",
      variation_group: "The variation group is superior."
    }

    text[group]
  end

  def format_calculator(calculator)
    groups = {
      control_group: format_group(calculator.control_group),
      variation_group: format_group(calculator.variation_group)
    }
    better_group = format_better_group(calculator.better_group)
    confidence = format_confidence(calculator.confident?)

    "CONTROL   #{groups[:control_group]}\n\n" \
    "VARIATION #{groups[:variation_group]}\n\n" \
    "#{better_group}\n" \
    "#{confidence}\n"
  end

  def format_confidence(confident)
    if confident
      "We are confident about the difference between these groups."
    else
      "We are not confident about the difference between these groups."
    end
  end

  def format_group(group)
    name = group.name
    conversions = group.conversions
    views = group.views
    rate = format_pct(group.conversion_rate)
    error = format_pct(group.conversion_rate_error)

    "Group #{name}\n" \
    "  #{conversions} conversions from #{views} views\n" \
    "  #{rate} \xc2\xb1 #{error} conversion rate"
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
