class Robot
  attr_accessor :name
  require_relative 'name_generator'

  def initialize
    @name = NameGenerator.robot_name
  end
end

robot = Robot.new
robot2 = Robot.new
puts "My pet robots are named #{robot.name} and #{robot2.name}..." <<
  " but I never talk to them."
