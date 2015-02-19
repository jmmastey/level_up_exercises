class TemperatureTypeParameter
  attr_reader :name, :value, :type, :units, :time_layout

  def initialize(attrs)
    @name = attrs[:name]
    @value = attrs[:value]
    @type = attrs[:@type]
    @units = attrs[:@units]
    @time_layout = attrs[:@time_layout]
  end
end