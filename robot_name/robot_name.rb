require 'set'

class NameCollisionError < RuntimeError; end

class RobotRegistry
  attr_reader :registry

  def initialize
    @registry = Set.new
  end

  def insert(robot)
    cautious_insert(robot)
  end

  def cautious_insert(robot)
    unless valid_name?(robot)
      raise NameCollisionError, 'That robot name is invalid!'
    end

    if registered?(robot)
      raise NameCollisionError, 'That robot name is already registered!'
    end

    @registry << robot.name
  end

  def registered?(robot)
    @registry.member?(robot.name)
  end

  def valid_name?(robot)
    valid_name = /[[:alpha:]]{2}[[:digit:]]{3}/
    robot.name =~ valid_name
  end
end

class Robot
  attr_accessor :name

  def initialize(args = {})
    @name_generator = args[:name_generator]
    create_name
  end

  def create_name
    if @name_generator
      @name = @name_generator.call
    else
      chars = ('A'..'Z').to_a * 2
      nums  = (0..9).to_a * 3
      @name = (chars.sample(2) + nums.sample(3)).join('')
    end
  end
end

reg = RobotRegistry.new
robot = Robot.new
reg.insert(robot)

puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
generator = -> { 'AA111' }
susan = Robot.new(name_generator: generator)
jerry = Robot.new(name_generator: generator)

reg.insert(susan)
reg.insert(jerry)
