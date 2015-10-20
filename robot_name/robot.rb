require_relative 'robot_name_registry'
require_relative 'default_robot_name_generator'

class InvalidNameFormatError < RuntimeError
  def initialize(name)
    super("Invalid robot name, #{name}.")
  end
end

class Robot

  attr_reader :name

  VALID_NAME_REGEXP = /\A[[:alpha:]]{2}[[:digit:]]{3}\Z/

  private_constant :VALID_NAME_REGEXP

  def initialize(name_generator = DefaultRobotNameGenerator::RANDOM_NAME,
                 registry = RobotNameRegistry.instance)

    @name = name_generator.call
    fail InvalidNameFormatError, @name unless @name =~ VALID_NAME_REGEXP

    registry << @name
  end

end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

a = Robot.new(-> { 'AA111' })
puts a.name

# a = Robot.new(-> { 'Bad' })
# puts a.name

# a = Robot.new(-> { 'AA111' })
# puts a.name