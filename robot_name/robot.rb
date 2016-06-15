require_relative 'robot_name'

class NameCollisionError < RuntimeError; end

class Robot
  CHARS = ('A'..'Z').to_a
  NUMS = (1..10).to_a
  ERROR_MESSAGE = 'There was a problem generating the robot name!'.freeze

  attr_accessor :name

  def initialize(args = {})
    @name_generator = args[:name_generator]
    @name = create_name
    add_name_to_registry
  end

  def create_name
    return @name_generator.call if @name_generator
    generate_name
  end

  def generate_name
    CHARS.sample(2).join + NUMS.shuffle.take(3).join
  end

  def valid_name?
    valid_format? && not_in_the_registry?
  end

  def valid_format?
    @name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end

  def not_in_the_registry?
    !RobotNames.registry.include?(@name)
  end

  def add_name_to_registry
    raise NameCollisionError, ERROR_MESSAGE unless valid_name?
    RobotNames.add_to_registry(@name)
  end
end

# robot = Robot.new
# puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
generator = -> { 'AA111' }
Robot.new(name_generator: generator)
Robot.new(name_generator: generator)
