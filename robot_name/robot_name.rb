require_relative "robotnamegenerator"

class Robot
  attr_accessor :name

  class NameCollisionError < RuntimeError
    def initialize(message = "Name already exists in robot registry!")
      super
    end
  end

  class InvalidNameError < RuntimeError
    def initialize(message = "Invalid name for a robot! How rude!")
      super
    end
  end

  def self.registry
    @registry ||= []
  end

  def initialize(args = {})
    @name_generator = args[:name_generator] || RobotNameGenerator.generator

    @name = @name_generator.call
    validate_robot

    Robot.registry << @name
  end

  def validate_robot
    raise InvalidNameError unless valid_name?
    raise NameCollisionError if Robot.registry.include?(name)
  end

  def valid_name?
    name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."
second_robot = Robot.new
puts "My other pet robot's name is #{second_robot.name}."

# Errors!
generator = -> { 'AA111' }
begin
  Robot.new(name_generator: generator)
  Robot.new(name_generator: generator)
rescue RuntimeError => e
  puts e.message
end
