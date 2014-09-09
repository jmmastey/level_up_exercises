class Arrowhead
  attr_accessor :name, :region, :shape

  def initialize(args)
    @name = args[:name]
    @region = args[:region]
    @shape = args[:shape]
  end

end

