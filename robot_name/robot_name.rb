class NameCollisionError < RuntimeError; end

class RobotNameGenerator
  @@registry ||= []
  NAME_COLLISION_ERROR_MESSAGE = 'There was a problem generating the robot name!'

  def call
    char = -> { ('A'..'Z').to_a.sample }
    num = -> { rand(10) }

    @name = "#{char.call}#{char.call}#{num.call}#{num.call}#{num.call}"

    if !(@name =~ /[[:alpha:]]{2}[[:digit:]]{3}/) || @@registry.include?(@name)
      raise NameCollisionError, NAME_COLLISION_ERROR_MESSAGE
    end

    @@registry << @name

    @name
  end
end

class Robot
  attr_accessor :name

  def initialize(name_generator = RobotNameGenerator.new)
    @name = name_generator.call
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
