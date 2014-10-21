# Domain object designed to capture traits of an arrow head stone tip
class Arrowhead
  attr_reader :region, :shape, :name

  def initialize(region, shape, name)
    @region = region
    @shape = shape
    @name = name
  end

  def to_s
    "You have a(n) '#{@name}' arrowhead.  Probably priceless."
  end
end
