class RobotRegistery 
  attr_reader :names

  def initialize(names = [])
    @names = names
  end

  def add_name(name)
    if !@names.include? name
      @names << name
      true
    else
      false
    end
  end

  def contains?(name)
    @names.include? name
  end
end
