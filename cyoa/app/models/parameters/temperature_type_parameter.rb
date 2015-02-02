class TemperatureTypeParameter
  attr_reader :name, :value, :type, :units, :time_layout

  def initialize(maxt_attrs)
    @name = maxt_attrs[:name]
    @value = maxt_attrs[:value]
    @type = maxt_attrs[:@type]
    @units = maxt_attrs[:@units]
    @time_layout = maxt_attrs[:@time_layout]
  end
end