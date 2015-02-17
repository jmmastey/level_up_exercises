load 'namegenerator.rb'

# Prints robot's name
class Robot
  attr_accessor :robotname

  def initialize(args)
    @robotname = NameGenerator.name(args)
  end

  def print_robot
    puts "My pet robot's name is #{@robotname}"
  end
end

var = {}
robot = Robot.new(var)
robot.print_robot

var[:k] = 'AA111'
robot_1 = Robot.new(var)
robot_1.print_robot
# Error
robot_2 = Robot.new(var)
robot_2.print_robot
