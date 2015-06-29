class RobotRegistry
  attr_accessor :names

  def initialize
    @names = []
  end

  def add_name(name)
    @names << name
  end
end
