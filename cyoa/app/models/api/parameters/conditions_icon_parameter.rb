class ConditionsIconParameter
  attr_reader :name, :icon_link, :type, :time_layout

  def initialize(conditions_icon)
    @name = conditions_icon[:name]
    @icon_link = conditions_icon[:icon_link]
    @type = conditions_icon[:@type]
    @time_layout = conditions_icon[:@time_layout]
  end
end