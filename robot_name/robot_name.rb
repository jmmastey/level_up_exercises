class RobotNames
  @registry ||= []

  class << self
    attr_accessor :registry
  end

  def self.add_to_registry(name)
    @registry << name
  end
end
