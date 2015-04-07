class RobotRegistry
  attr_reader :names

  def initialize(names = [])
    @names = names.uniq
  end

  def add_name(name)
    if !@names.include?(name)
      @names << name
    end
  end

  def contains?(name)
    @names.include?(name)
  end
end
