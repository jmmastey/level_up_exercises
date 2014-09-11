class ArrowHead
  attr_reader :type, :name, :region

  def initialize(values)
    @type = values[:type]
    @name = values[:name]
    @region = values[:region]
  end

  def to_s
    @name
  end
end
