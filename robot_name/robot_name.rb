require_relative 'name_generator'

class Robot
  attr_accessor :name

  def initialize(name_generator)
    @name = name_generator.robot_name
  end
end

generator = NameGenerator.new
robot = Robot.new(generator)
robot2 = Robot.new(generator)
puts "My pet robots are named #{robot.name} and #{robot2.name}..." <<
  " but I never talk to them."
