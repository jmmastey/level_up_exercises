require_relative 'name_collision_error'

class RobotNameRegistry
  attr_accessor :registry
  def initialize
    @registry = []
  end

  def add(name)
    validate(name)
    @registry << name
  end

  def exist?(name)
    @registry.include?(name)
  end

  private

  def validate(name)
    raise NameCollisionError if exist?(name)
  end
end