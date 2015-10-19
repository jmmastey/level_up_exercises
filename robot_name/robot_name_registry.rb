require 'set'
require 'singleton'

class NameCollisionError < RuntimeError
  def initialize(name)
    super("Robot name #{name} is already in use.")
  end
end

class RobotNameRegistry
  include Singleton

  def initialize
    @registry = Set.new
  end

  def <<(name)
    fail NameCollisionError, name if @registry.include?(name)
    @registry << name
  end

  self
end
