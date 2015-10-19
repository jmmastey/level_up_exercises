require 'set'
require 'singleton'

class NameCollisionError < RuntimeError; end
class InvalidNameFormatError < RuntimeError; end

class DefaultRobotNameGenerator < Proc
  CHAR_GENERATOR = -> { ('A'..'Z').to_a.sample }
  NUM_GENERATOR = -> { rand(10) }

  private_constant :CHAR_GENERATOR, :NUM_GENERATOR

  def self.new
    super() do
      "#{CHAR_GENERATOR.call}#{CHAR_GENERATOR.call}#{NUM_GENERATOR.call}#{NUM_GENERATOR.call}#{NUM_GENERATOR.call}"
    end
  end

  self

end

class RobotNameRegistry
  include Singleton

  def initialize
    @registry = Set.new
  end

  def include?(name)
    @registry.include?(name)
  end

  def <<(name)
    @registry << name
  end

  self
end

class Robot
  attr_accessor :name

  VALID_NAME_REGEXP = /\A[[:alpha:]]{2}[[:digit:]]{3}\Z/

  def initialize(name_generator = DefaultRobotNameGenerator.new, registry = RobotNameRegistry.instance)
    @name = name_generator.call

    unless name =~ VALID_NAME_REGEXP
      raise InvalidNameFormatError, "Invalid robot name, #{@name}.  It must be 2 characters follow by 3 numbers."
    end
    raise NameCollisionError, "Robot name, #{@name}, is already in use." if registry.include?(name)

    registry << @name
  end

  self

end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

a = Robot.new(-> { 'AA111' })
puts a.name

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
